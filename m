Received: from eggs.gnu.org ([2001:4830:134:3::10]:37193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWHHL-0006hJ-6W
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 03:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWHHH-00081B-Qr
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 03:51:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWHHH-00080c-G5
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 03:50:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 543DC3164677
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 08:50:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-16-marcandre.lureau@redhat.com>
	<87lg53olyf.fsf@dusky.pond.sub.org>
	<CAMxuvaxENFTV9SV0jF9Q9qcf2p5vAdPZ5t8BumQLVXvqP9knrA@mail.gmail.com>
Date: Mon, 10 Dec 2018 09:50:52 +0100
In-Reply-To: <CAMxuvaxENFTV9SV0jF9Q9qcf2p5vAdPZ5t8BumQLVXvqP9knrA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Sat, 8 Dec 2018
	15:20:18 +0400")
Message-ID: <8736r5n4sz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 15/27] qapi: rename allow_dict to
 allow_implicit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> On Wed, Dec 5, 2018 at 10:41 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > This makes it a bit clearer what is the intent of the dictionnary for
>>
>> dictionary
>
> sigh, this must be a very common misspell (dictionnaire in french)

Muscle memory...

>> > the check_type() function, since there was some confusion on a
>> > previous iteration of this series.
>>
>> I don't remember... got a pointer to that confusion handy?
>
> https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg01584.html

Thanks!

My review comment was

    > diff --git a/scripts/qapi.py b/scripts/qapi.py
    > index df2a304e8f..15711f96fa 100644
    > --- a/scripts/qapi.py
    > +++ b/scripts/qapi.py
    > @@ -696,7 +696,15 @@ def check_type(info, source, value, allow_array=
=3DFalse,
    >          return
    >=20=20
    >      if not allow_dict:
    > -        raise QAPISemError(info, "%s should be a type name" % source)
    > +        if isinstance(value, dict) and 'type' in value:
    > +            check_type(info, source, value['type'], allow_array,
    > +                       allow_dict, allow_optional, allow_metas)
    > +            if 'if' in value:
    > +                check_if(value, info)
    > +            check_unknown_keys(info, value, {'type', 'if'})
    > +            return
    > +        else:
    > +            raise QAPISemError(info, "%s should be a type name" % so=
urce)

    @allow_dict becomes a misnomer: dictionaries are now always allowed, but
    they have different meaning (implicit type vs. named type with
    additional attributes).

    Rename to @allow_implicit?

As far as I can tell, it's not an issue in the current version of your
patches anymore:

    def check_type(info, source, value, allow_array=3DFalse,
                   allow_implicit=3DFalse, allow_optional=3DFalse,
                   allow_metas=3D[]):
        global all_names

        if value is None:
            return

        # Check if array type for value is okay
        if isinstance(value, list):
            if not allow_array:
                raise QAPISemError(info, "%s cannot be an array" % source)
            if len(value) !=3D 1 or not isinstance(value[0], str):
                raise QAPISemError(info,
                                   "%s: array type must contain single type=
 name" %
                                   source)
            value =3D value[0]

        # Check if type name for value is okay
        if isinstance(value, str):
            if value not in all_names:
                raise QAPISemError(info, "%s uses unknown type '%s'"
                                   % (source, value))
            if not all_names[value] in allow_metas:
                raise QAPISemError(info, "%s cannot use %s type '%s'" %
                                   (source, all_names[value], value))
            return

        if not allow_implicit:
            raise QAPISemError(info, "%s should be a type name" % source)

        if not isinstance(value, OrderedDict):
            raise QAPISemError(info,
                               "%s should be a dictionary or type name" % s=
ource)

        # value is a dictionary, check that each member is okay
        for (key, arg) in value.items():
            check_name(info, "Member of %s" % source, key,
                       allow_optional=3Dallow_optional)
            if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswi=
th('has_'):
                raise QAPISemError(info, "Member of %s uses reserved name '=
%s'"
                                   % (source, key))
            # Todo: allow dictionaries to represent default values of
            # an optional argument.
            if isinstance(arg, dict):
                check_known_keys(info, "member '%s' of %s" % (key, source),
                                 arg, ['type'], ['if'])
                typ =3D arg['type']
            else:
                typ =3D arg
            check_type(info, "Member '%s' of %s" % (key, source),
                       typ, allow_array=3DTrue,
                       allow_metas=3D['built-in', 'union', 'alternate', 'st=
ruct',
                                    'enum'])


>> > Suggested-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
