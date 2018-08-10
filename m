Received: from eggs.gnu.org ([2001:4830:134:3::10]:37533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fo6QH-0005R5-QI
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fo6QG-0002Yz-TJ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:21:41 -0400
Date: Fri, 10 Aug 2018 09:21:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180810122132.GN15372@localhost.localdomain>
References: <20180808123934.17450-1-alex.bennee@linaro.org>
	<20180808123934.17450-2-alex.bennee@linaro.org>
	<20180810033200.GA8773@localhost.localdomain>
	<878t5eppm1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <878t5eppm1.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] scripts/decodetree.py: add a
 disassembly generator (HACK!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, Cleber Rosa <crosa@redhat.com>

On Fri, Aug 10, 2018 at 09:55:50AM +0100, Alex Benn=E9e wrote:
>=20
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Wed, Aug 08, 2018 at 01:39:31PM +0100, Alex Benn=E9e wrote:
> >> Given our issues with failing disassembly we could try and re-use th=
e
> >> decode tree data to output what instruction is being decoded. This
> >> will be used if registered as a fall-back for when the "proper"
> >> disassembler fails to decode an instruction.
> >>
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >
> > I don't have an opinion on the approach you are taking, but the
> > Python code you are adding is consistent with the existing style
> > of the script.
> >
> > That said, I find the existing code full of output() calls very
> > hard to read.  If anybody wants to volunteer to improve the
> > readability of the output generation, it would be welcome.
>=20
> If we expect to have the script output a number of different forms I
> guess re-factoring it with some sort of template based approach would b=
e
> worthwhile. I wonder if there are other examples in the code base? We
> wouldn't want to have multiple template types.

QAPI scripts also generates C code, and I find them more
readable[1].

I think a true template language would be even better than QAPI's
approach, but I don't see an obvious candidate that would be
worth adding another build dependency to QEMU.


[1] Compare:

def output_decl(self):
    global translate_scope
    global translate_prefix
    output('typedef ', self.base.base.struct_name(),
           ' arg_', self.name, ';\n')
    output(translate_scope, 'bool ', translate_prefix, '_', self.name,
           '(DisasContext *ctx, arg_', self.name,
           ' *a, ', insntype, ' insn);\n')

And:

def gen_visit_members_decl(name):
    return mcgen('''

void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **e=
rrp);
''',
                 c_name=3Dc_name(name))

--=20
Eduardo
