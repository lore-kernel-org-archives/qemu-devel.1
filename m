Received: from eggs.gnu.org ([2001:4830:134:3::10]:38307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkV2f-0005dm-Dw
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkV2b-00053U-CZ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkV2b-00053I-2n
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:45:49 -0400
Date: Wed, 23 Aug 2017 09:45:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823124544.GE27715@localhost.localdomain>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-8-marcandre.lureau@redhat.com>
	<87mv6z4ix5.fsf@dusky.pond.sub.org>
	<CAJ+F1CKT8MXVSP+UTu6C50Ue18GhiuXAE9rCQbTiB54iw6_YPA@mail.gmail.com>
	<87h8wzfsu4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87h8wzfsu4.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/26] qapi: add 'if' condition on
 top-level schema elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Aug 22, 2017 at 06:52:19PM +0200, Markus Armbruster wrote:
> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> writes:
[...]
> >>> +    def func_wrapper(self, *args, **kwargs):
> >>> +        funcname =3D self.__class__.__name__ + '.' + func.__name__
> >>> +        ifcond =3D args[-1]
> >>> +        save =3D {}
> >>> +        for mem in self.if_members:
> >>> +            save[mem] =3D getattr(self, mem)
> >>> +        func(self, *args, **kwargs)
> >>> +        for mem, val in save.items():
> >>> +            newval =3D getattr(self, mem)
> >>> +            if newval !=3D val:
> >>> +                assert newval.startswith(val)
> >>> +                newval =3D newval[len(val):]
> >>> +                val +=3D gen_if(ifcond, funcname)
> >>
> >> Emitting comments pointing to the QAPI schema into the generated cod=
e is
> >> often helpful.  But this one points to QAPI generator code.  Why is =
that
> >> useful?
> >
> > That was mostly useful during development, removed
> >
> >>
> >>> +                val +=3D newval
> >>> +                val +=3D gen_endif(ifcond, funcname)
> >>> +            setattr(self, mem, val)
> >>> +
> >>> +    return func_wrapper
> >>> +
> >>
> >> pep8 again:
> >>
> >>     scripts/qapi.py:1955:1: E302 expected 2 blank lines, found 1
> >>
> >> Peeking ahead: this function is used as a decorator.  Let's help the
> >> reader and mention that in the function comment, or by naming the
> >> function suitably.  ifcond_decorator?
> >
> > done
> >
> >>
> >> Messing with the wrapped method's class's attributes is naughty.  Wo=
rse,
> >> it's hard to understand.  What alternatives have you considered?
> >
> > Well, I started writing the code that checked if members got code
> > added, I had to put some enter()/leave() code everywhere. Then I
> > realize this could easily be the job for a decorator. I think the end
> > result is pretty neat.
>=20
> I think "clever" would describe it better than "neat".  Possibly "too
> clever".

FWIW, I was investigating something else in the series and took a
while to understand how the #if lines were magically appearing on
self.decl and self.defn.

I'd prefer something simpler like:

    def cond(ifcond, s):
        if s:
            return gen_if(ifcond) + s + gen_endif(ifcond)
        return s

    def visit_command(self, name, info, arg_type, ret_type,
                      gen, success_response, boxed, ifcond):
        if not gen:
            return
        self.decl +=3D cond(ifcond, gen_command_decl(name, arg_type, boxe=
d, ret_type))
        if ret_type and ret_type not in self._visited_ret_types:
            self._visited_ret_types.add(ret_type)
            self.defn +=3D cond(ifcond,gen_marshal_output(ret_type))
        self.decl +=3D cond(ifcond, gen_marshal_decl(name))
        self.defn +=3D cond(ifcond, gen_marshal(name, arg_type, boxed, re=
t_type))
        self._regy +=3D cond(ifcond, gen_register_command(name, success_r=
esponse))

If all callers of some of the gen_*() functions above are wrapped
by ifcond(), then a decorator around them could still be useful.
But preferably if the decorator affects only the function
arguments and return value, not messing with the object
attributes or other state outside the function.

--=20
Eduardo
