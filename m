Received: from eggs.gnu.org ([2001:4830:134:3::10]:44787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1df7la-000407-7t
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1df7lX-0006Cz-Kq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1df7lX-0006CX-Be
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:53:59 -0400
Date: Tue, 8 Aug 2017 10:53:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170808105349.580a89a8@w520.home>
In-Reply-To: <CAMxP3BS+088_zjKMJeC0_g=sXiGqGPdj3UFD74URGFgef29kXA@mail.gmail.com>
References: <4E0AFA5F-44D6-4624-A99F-68A7FE52F397@meituan.com>
	<4b31a711-a52e-25d3-4a7c-1be8521097d9@redhat.com>
	<F99BFE80-FC15-40A0-BB3E-1B53B6CF9B05@meituan.com>
	<859362e8-0d98-3865-8bad-a15bfa218167@redhat.com>
	<20170726092931.0678689e@w520.home>
	<20170726190348-mutt-send-email-mst@kernel.org>
	<20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
	<20170731234626.7664be18@w520.home>
	<CAMxP3BTfMad-ycWHqmW+aVM7rv2CJSv-dmEFUveGBqAWvfbBjQ@mail.gmail.com>
	<20170801090158.35d18f10@w520.home>
	<CAMxP3BRkzXBRPZw9fpCu-w4Fusn6ng_knk1cAz=EDBAiw9UnqA@mail.gmail.com>
	<20170807095224.5438ef8c@w520.home>
	<CAMxP3BS+088_zjKMJeC0_g=sXiGqGPdj3UFD74URGFgef29kXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] =?utf-8?q?About_virtio_device_hotplug_in_Q35!_?=
 =?utf-8?b?44CQ5aSW5Z+f6YKu5Lu2LuiwqOaFjuafpemYheOAkQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

On Tue, 8 Aug 2017 09:44:56 +0800
Bob Chen <a175818323@gmail.com> wrote:

> 1. How to test the KVM exit rate?

You can use tracing: http://www.linux-kvm.org/page/Tracing
 
> 2. The switches are separate devices of PLX Technology
> 
> # lspci -s 07:08.0 -nn
> 07:08.0 PCI bridge [0604]: PLX Technology, Inc. PEX 8747 48-Lane, 5-Port
> PCI Express Gen 3 (8.0 GT/s) Switch [10b5:8747] (rev ca)
> 
> # This is one of the Root Ports in the system.
> [0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D
> DMI2
>              +-01.0-[01]----00.0  LSI Logic / Symbios Logic MegaRAID SAS
> 2208 [Thunderbolt]
>              +-02.0-[02-05]--
>              +-03.0-[06-09]----00.0-[07-09]--+-08.0-[08]--+-00.0  NVIDIA
> Corporation GP102 [TITAN Xp]
>              |                               |            \-00.1  NVIDIA
> Corporation GP102 HDMI Audio Controller
>              |                               \-10.0-[09]--+-00.0  NVIDIA
> Corporation GP102 [TITAN Xp]
>              |                                            \-00.1  NVIDIA
> Corporation GP102 HDMI Audio Controller
> 
> 
> 
> 
> 3. ACS
> 
> It seemed that I had misunderstood your point? I finally found ACS
> information on switches, not on GPUs.
> 
> Capabilities: [f24 v1] Access Control Services
> ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+
> DirectTrans+
> ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl-
> DirectTrans-

Yes, NVIDIA uses the same PLX PEX 8747 on the switches on the cards I
have access to.  Unfortunately the endpoints in my case do not support
ATS, so the endpoint cannot generate a pre-translated address that
would take advantage of the DT capability on the switch port if we were
to enable it.  Thanks,

Alex
