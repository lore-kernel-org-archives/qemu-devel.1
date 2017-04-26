Received: from eggs.gnu.org ([2001:4830:134:3::10]:57370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3KT1-0006SG-1X
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3KT0-0005ZE-7N
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:46:39 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3KT0-0005Yq-0J
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:46:38 -0400
Received: by mail-wm0-x22a.google.com with SMTP id w64so46481509wma.0
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 03:46:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fbf91cf1-53d1-4b75-74b3-fa9abefdd788@kaod.org>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
	<20170426023843.GJ16882@umbus.fritz.box>
	<fbf91cf1-53d1-4b75-74b3-fa9abefdd788@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 11:46:16 +0100
Message-ID: <CAFEAcA_WJP0tBKayzjZ4iVBCjfiQp+bGz_c2RpfwmhLwxM90ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/47] ppc-for-2.10 queue 20170424
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 26 April 2017 at 07:11, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> yes. May be we could add this flag :
>
>         --extra-cflags=3D-fsanitize=3Dundefined
>
> to the travis builds using clang ? It is reporting a couple of errors on =
ppc64
>
> target/ppc/translate.c:980:56: runtime error: left shift of negative valu=
e -32768
> target/ppc/translate.c:983:56: runtime error: left shift of negative valu=
e -16
> hw/usb/hcd-ohci.c:1122:9: runtime error: left shift of 15 by 28 places ca=
nnot be represented in type 'int'
> hw/usb/hcd-ohci.c:1122:9: runtime error: left shift of 15 by 28 places ca=
nnot be represented in type 'int'
> hw/usb/hcd-ohci.c:1179:12: runtime error: left shift of 15 by 28 places c=
annot be represented in type 'int'

All the stuff about shifts is false positives, because the sanitizer
doesn't know that -fwrapv makes these operations defined behaviour.

Newer versions of clang I think get this correct, and less new
but not ancient clang has a flag that says "don't report that
particular set of shift errors". For my pullreq tests at the moment
I just use grep to filter them out:
 https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/greplogs
but as the TODO note says I should find out what the right ubsan
flag is to suppress them at source.

thanks
-- PMM
