Received: from eggs.gnu.org ([2001:4830:134:3::10]:43795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkIM-0002XI-3L
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkIL-00086Z-1p
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:21:54 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZkIK-00085x-QS
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:21:52 -0500
Received: by mail-wm0-x22d.google.com with SMTP id 141so7995356wme.3
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:21:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zi6uochn.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-10-marcandre.lureau@redhat.com>
	<87zi6uochn.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2018 22:21:50 +0100
Message-ID: <CAJ+F1CKuG3D5UZDuzpV_z9rzwNu367V8gj9UN5xYhCimMkGcRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/50] qapi: add #if/#endif helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Dec 7, 2017 at 3:10 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Add helpers to wrap generated code with #if/#endif lines.
>>
>> Add a function decorator that will be used to wrap visitor methods.
>> The decorator will check if code was generated before adding #if/#endif
>> lines. Used in the following patches.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi.py | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>> index 2a8e60e975..94b735d8d6 100644
>> --- a/scripts/qapi.py
>> +++ b/scripts/qapi.py
>> @@ -1897,6 +1897,61 @@ def guardend(name):
>>                   name=3Dguardname(name))
>>
>>
>> +def gen_if(ifcond):
>> +    if not ifcond:
>> +        return ''
>> +    if isinstance(ifcond, str):
>> +        ifcond =3D [ifcond]
>
> Perhaps we should take this normalization step in the QAPISchema
> constructors.

Yes, it's not very convenient though, I added a TODO note

>
>> +    ret =3D ''
>> +    for ifc in ifcond:
>> +        ret +=3D mcgen('''
>> +#if %(cond)s
>> +''', cond=3Difc)
>> +    return ret
>> +
>> +
>> +def gen_endif(ifcond):
>> +    if not ifcond:
>> +        return ''
>> +    if isinstance(ifcond, str):
>> +        ifcond =3D [ifcond]
>> +    ret =3D ''
>> +    for ifc in reversed(ifcond):
>> +        ret +=3D mcgen('''
>> +#endif /* %(cond)s */
>> +''', cond=3Difc)
>> +    return ret
>> +
>> +
>> +# Wrap a method to add #if / #endif to generated code, only if some
>> +# code was generated. The method must have an 'ifcond' argument.
>> +# self must have 'if_members' listing the attributes to wrap.
>> +def ifcond_decorator(func):
>> +
>> +    def func_wrapper(self, *args, **kwargs):
>> +        import inspect
>
> Is hiding imports in function a good idea?

I believe it's best to restrict the import to the scope it is being
used, especially if it's very specific to that place. Some code do
that already.

>
>> +        idx =3D inspect.getargspec(func).args.index('ifcond')
>> +        ifcond =3D args[idx - 1]
>> +        save =3D {}
>> +        for mem in self.if_members:
>> +            save[mem] =3D getattr(self, mem)
>> +        func(self, *args, **kwargs)
>> +        for mem, val in save.items():
>> +            newval =3D getattr(self, mem)
>> +            if newval !=3D val:
>> +                assert newval.startswith(val)
>> +                newval =3D newval[len(val):]
>> +                if newval[0] =3D=3D '\n':
>> +                    val +=3D '\n'
>> +                    newval =3D newval[1:]
>> +                val +=3D gen_if(ifcond)
>> +                val +=3D newval
>> +                val +=3D gen_endif(ifcond)
>> +            setattr(self, mem, val)
>> +
>> +    return func_wrapper
>> +
>> +
>>  def gen_enum_lookup(name, values, prefix=3DNone):
>>      ret =3D mcgen('''
>
> My gut feeling is still "too clever by half", but i'm reserving
> judgement until after review of its use, and exploration of
> alternatives.
>

Could easily be done as a follow-up.

thanks

--=20
Marc-Andr=C3=A9 Lureau
