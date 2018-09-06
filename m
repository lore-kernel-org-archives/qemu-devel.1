Received: from eggs.gnu.org ([2001:4830:134:3::10]:59468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxxix-0006PK-BD
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxxiu-00022g-HS
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:05:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxxis-0001ar-Ie
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:05:40 -0400
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
	<20180906151227.25514-11-marcandre.lureau@redhat.com>
	<02fe751d-661d-04ab-44ba-caf3469eebcd@redhat.com>
	<CAJ+F1C+rXupKahjD5rDDfxKKg7iw9z7EhGqyyk=S3x6vVKi+pQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7d0b369-eac5-dcde-1f6c-c6e005332b12@redhat.com>
Date: Thu, 6 Sep 2018 12:05:19 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+rXupKahjD5rDDfxKKg7iw9z7EhGqyyk=S3x6vVKi+pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] vl: list user creatable propeties if
 '?' as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

On 09/06/2018 11:27 AM, Marc-Andr=C3=A9 Lureau wrote:

> We use name=3Dtype (text) for devices properties, ex:
>=20
> qemu-system-x86_64 -device tpm-tis,?
> tpm-tis.tpmdev=3Dstr (ID of a tpm to use as a backend)
> tpm-tis.irq=3Duint32
> tpm-tis.tpm-tis-mmio[0]=3Dchild<qemu:memory-region>
>=20
> But
> qemu-img create -f qcow2 -o ?
>=20
>      size             Virtual disk size
>      compat           Compatibility level (0.10 or 1.1)
>      backing_file     File name of a base image
>=20
> I think I like more "name=3Dtype - text" form I introduced in "improve
> qemu_opts_print_help() output". I guess I should change device
> properties help for consistency then.

I don't have a strong preference for one form over the other, so much as=20
consistency in the various applications using the form.


>>> +static gint
>>> +pstrcmp(const char **a, const char **b)
>>> +{
>>> +    return g_strcmp0(*a, *b);
>>> +}
>>
>> This is the second time your series has added this static helper. Shou=
ld
>> it be a common helper instead?
>=20
> as qemu_pstrcmp in cutils? inline in the header?

Does glib not already have such a helper? cutils sounds as good a place=20
as any, although inline may be at odds with typically using it as a=20
callback function (I don't know how well the compiler and linker handle=20
such a situation).

>=20
>>
>>
>>> +        g_ptr_array_sort(array, (GCompareFunc)pstrcmp);
>>> +        for (i =3D 0; i < array->len; i++) {
>>> +            error_printf("%s\n", (char *)array->pdata[i]);
>>> +        }
>>> +        g_ptr_array_set_free_func(array, g_free);
>>> +        g_ptr_array_free(array, true);
>>> +        exit(0);
>>
>> Again, printing to stderr then exiting with status 0 is awkward.  Prin=
t
>> to stdout when successfully offering help text.
>=20
> We use error_printf() for qdev list (qdev_device_help), which
> redirects to monitor or stderr.
>=20
> Should I also change ir for consistency? hopefully nobody relies on
> the output going to stderr...

I don't worry too much about that. We've already fixed other places=20
where qemu binaries were antisocial, such as commit ac1307ab fixing=20
'qemu-img --help' to give status 0 instead of 1.

In general, when a user asks for help, the help text should go to=20
stdout, and the exit status should be 0 (unless you go to great lengths=20
to also detect write failures such as ENOSPC or EPIPE, in which case you=20
should ALSO attempt to write to stderr prior to exiting with nonzero=20
status that you couldn't output the help text - but since FILE* I/O can=20
cache things, detecting all possible write errors is not reliable unless=20
you check the result of fclose(stdout), which in turn has to be deferred=20
to the end of your program execution, generally via atexit().  The extra=20
complications and code maintenance for checking for --help output=20
failures is something that I'm personally okay with skipping).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
