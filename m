Received: from eggs.gnu.org ([2001:4830:134:3::10]:56646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpyvK-00037f-SI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpyvJ-0004y6-NI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cpyvJ-0004wq-EQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:08:41 -0400
References: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_QWrU6AGfWz1iNfgYJUuKJ=hyUOHkPOo8XKyyV=4WOSw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3db0559-7c08-765e-5e1e-63da4f2dcca0@redhat.com>
Date: Mon, 20 Mar 2017 16:08:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_QWrU6AGfWz1iNfgYJUuKJ=hyUOHkPOo8XKyyV=4WOSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hmp: gpa2hva and gpa2hpa hostaddr
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 20/03/2017 15:56, Peter Maydell wrote:
> On 20 March 2017 at 14:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> These commands are useful when testing machine-check passthrough.
>> gpa2hva is useful to inject a MADV_HWPOISON madvise from gdb, while
>> gpa2hpa is useful to inject an error with the mce-inject kernel
>> module.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hmp-commands.hx |  32 ++++++++++++++++++
>>  monitor.c       | 101 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 133 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 8819281..0aca984 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -526,6 +526,38 @@ Dump 80 16 bit values at the start of the video m=
emory.
>>  ETEXI
>=20
> I have some comments which feel kind of nit-picky, but since this
> is a public-facing HMP API I think they need attention since we only
> get one chance to get it right.
>=20
>>      {
>> +        .name       =3D "gpa2hva",
>> +        .args_type  =3D "addr:l",
>> +        .params     =3D "addr",
>> +        .help       =3D "print the host virtual address corresponding=
 to a guest physical address",
>> +        .cmd        =3D hmp_gpa2hva,
>> +    },
>=20
> How does this work for guest CPUs which have more than one physical
> address space (eg ARM TrustZone)? There's no ability here to specify
> the secure/nonsecure transaction attribute that you need to distinguish
> which kind of guest physical address you're talking about.
>=20
> The command also doesn't let you specify which CPU you care about,
> which is bad because they don't all have to have the same address map.

It just uses address_space_memory currently.  I can make it use the
current CPU address space too, similar to x and xp; it's the same for my
own use.

> The documentation should also say what happens if the guest physaddr
> doesn't correspond to RAM.

An error? :)

>> +#ifdef CONFIG_LINUX
>> +    {
>> +        .name       =3D "gpa2hpa",
>> +        .args_type  =3D "addr:l",
>> +        .params     =3D "addr",
>> +        .help       =3D "print the host physical address correspondin=
g to a guest physical address",
>> +        .cmd        =3D hmp_gpa2hpa,
>> +    },
>> +#endif
>> +
>> +STEXI
>> +@item gpa2hpa @var{addr}
>> +@findex gpa2hpa
>> +Print the host physical address at which the guest's physical address=
 @var{addr}
>> +is mapped.
>=20
> ...what if you're on a system where host RAM exists at multiple host
> physical addresses?

It gives whatever the host OS thinks it's the corresponding host
physical address.  It's what happens to be in the page tables for the HVA=
.

> What if the RAM happens to be paged out?
> (Plus the remarks for gpa2hva apply.)

Another error? :)

Paolo
