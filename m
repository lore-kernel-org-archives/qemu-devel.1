Received: from eggs.gnu.org ([2001:4830:134:3::10]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fognH-0006ZU-5g
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 23:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fognF-0004LD-PM
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 23:11:51 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:55684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aoates@google.com>) id 1fognF-0004IK-HU
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 23:11:49 -0400
Received: by mail-it0-x243.google.com with SMTP id d10-v6so8023565itj.5
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 20:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
	<20180729143545.6978-2-samuel.thibault@ens-lyon.org>
	<CAFEAcA8tX0_MNg99oorgOWarJa8Oy+gFFwoRys-fU7ZX3_Ufng@mail.gmail.com>
	<CAJ1tprAuf1mWtpw+4M3QFZyrDz22TMcnGS9xkhQn6Q9UQTrwiw@mail.gmail.com>
	<CAFEAcA_pj4tFE2tyrbRtvJnPoeRekDXtVJCzgSeFiiK=sxg4Aw@mail.gmail.com>
	<CAJ1tprAyHqgH1mHkeLu6qU1Fr8O-B5ebJ3Cfw8e_nHMYSYXfmQ@mail.gmail.com>
	<CAFEAcA8DdkVB6LG=wq10wJDBjZgScdC_6tavtMzEi-UgGXjEKw@mail.gmail.com>
	<CAJ1tprA11Q+kjkdmmpmJRiLbDveWR6qzKY3hz_FbRXAUPpXy6A@mail.gmail.com>
In-Reply-To: <CAJ1tprA11Q+kjkdmmpmJRiLbDveWR6qzKY3hz_FbRXAUPpXy6A@mail.gmail.com>
From: Andrew Oates <aoates@google.com>
Date: Sat, 11 Aug 2018 23:11:35 -0400
Message-ID: <CAJ1tprBXs6PWP=SsjtPOPNxPJfvWsWFoHCAhovJEGn4=mf8_tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/1] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, stefanha@redhat.com, "J. Kiszka" <jan.kiszka@siemens.com>

Ping --- would you like me to resubmit the patch using CONFIG_BSD?

Cheers,
~Andrew


On Wed, Aug 1, 2018 at 10:39 AM Andrew Oates <aoates@google.com> wrote:

>
>
>
> On Wed, Aug 1, 2018 at 6:10 AM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On 1 August 2018 at 00:25, Andrew Oates <aoates@google.com> wrote:
>> > Both CONFIG_BSD and not-CONFIG_LINUX work on macOS.  I unfortunately
>> don't
>> > have access to any other BSDs to test them, though.
>>
>> Is there an easy way to test it? The QEMU makefiles have some
>> runes for setting up a BSD VM...
>>
>
> Ok, it turns out that SOCK_DGRAM+IPPROTO_ICMP isn't actually supported on
> FreeBSD---tested in qemu (thanks for the tip!).
>
> I didn't actually boot up NetBSD or OpenBSD, but poking around the kernel
> source I found for them it appears they have the same restriction:
> https://github.com/freebsd/freebsd/blob/master/sys/netinet/in_proto.c
> https://github.com/openbsd/src/blob/master/sys/netinet/in_proto.c
>
> http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/netinet/in_proto.c?rev=1.128&content-type=text/x-cvsweb-markup
>
> (search for SOCK_DGRAM and IPPROTO_ICMP in the above).
>
> So I don't think ICMP via SLIRP would work at all in the other BSDs,
> meaning this patch is a no-op for them either way.  If we _were_ to make
> SLIRP+ICMP work in *BSD, we'd presumably want to do it with a
> SOCK_RAW+IPPROTO_ICMP socket (which would require special permissions to
> create), which would mean an included IP header---so I think that #ifdef
> CONFIG_BSD here is defensible.
>
> I did some poking for Solaris and Haiku and didn't find much, though it
> looks like the version of ping included w/ Haiku uses SOCK_RAW rather than
> SOCK_DGRAM, so it may be in the same boat as non-OSX-BSDs (
> https://github.com/haiku/haiku/blob/master/src/bin/network/ping/ping.c#L205
> ).
>
> ~Andrew
>
>
>>
>> thanks
>> -- PMM
>>
>
