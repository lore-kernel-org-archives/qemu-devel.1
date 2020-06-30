Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89297C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CCE206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4sDpDFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CCE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGS5-0008Qk-K1
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqGRO-0007pm-Oa
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:36:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqGRL-0005yf-Et
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593524206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5vPxYGvR4CsPBMkBm5MUON3diyNcSe34LxuPdZq4FY=;
 b=c4sDpDFGcsiOs398MQpOzALfQVUN2DUjI6jPL0wZao9bk5FSh7SmdC515bifzA2nFqO3nz
 O1lZnu8VYg/pdIPcQjtMvW7pxoTpTE+on7W0gG047NKYQHKqIzlHJsSY3+C5XXlotyiGKi
 +/+xRSIO+cjYSN6DQHDEkYwgtEI3rsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-CMK8_DvFM_Sjilx9lDizfQ-1; Tue, 30 Jun 2020 09:36:36 -0400
X-MC-Unique: CMK8_DvFM_Sjilx9lDizfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86D88804001;
 Tue, 30 Jun 2020 13:36:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-46.ams2.redhat.com [10.36.112.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79090619C1;
 Tue, 30 Jun 2020 13:36:28 +0000 (UTC)
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
 <CAAdtpL7MObRjk77ZFsNF4Xoghdj33mwufZ9s3L8fAC3XxkJCqA@mail.gmail.com>
 <CAHiYmc59Ahpii2dvhVD8EPK4qzc8y2RNTwTbp4L1d2Mjun+Phg@mail.gmail.com>
 <3b75d15d-9195-bcd5-87aa-e243547552e5@amsat.org>
 <CAHiYmc4NOrG-ETX_rLGGR=Cac_Q_hNfjAsS3mF6PpAFFjLDHGw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ef829b6-6492-de7b-d668-550d04228844@redhat.com>
Date: Tue, 30 Jun 2020 15:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4NOrG-ETX_rLGGR=Cac_Q_hNfjAsS3mF6PpAFFjLDHGw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/2020 13.17, Aleksandar Markovic wrote:
> 
> 
> уторак, 30. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org 
> <mailto:f4bug@amsat.org>> је написао/ла:
> 
>     On 6/30/20 1:01 PM, Aleksandar Markovic wrote:
>      >
>      >
>      > уторак, 30. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>
>      > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> је написао/ла:
>      >
>      >     On Tue, Jun 30, 2020 at 12:52 PM Philippe Mathieu-Daudé
>      >     <f4bug@amsat.org <mailto:f4bug@amsat.org>
>     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> wrote:
>      >     >
>      >     > On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
>      >     > >
>      >     > >
>      >     > > уторак, 30. јун 2020., Philippe Mathieu-Daudé
>     <f4bug@amsat.org <mailto:f4bug@amsat.org>
>      >     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>
>      >     > > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>
>     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>>> је написао/ла:
>      >     > >
>      >     > >     Hi,
>      >     > >
>      >     > >     Following Jiaxun Yang's patch and discussion:
>      >     > > https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>
>      >     <https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>>
>      >     > >     <https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>
>      >     <https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>>>
>      >     > >
>      >     > >     - Rename the current machine as 'malta-virt' (keeping
>      >     'malta' aliased)
>      >     > >       Suggestions for better names are welcome, maybe
>      >     'malta-unreal' or
>      >     > >       'malta-unleashed' instead?
>      >     > >     - Add 'malta-phys' which respects hardware
>     restrictions (on
>      >     RAM so far)
>      >     > >     - Unleash 'malta-virt' to allow more than 2GB on 64-bit
>      >     > >
>      >     > >     Philippe Mathieu-Daudé (7):
>      >     > >       hw/mips/malta: Trivial code movement
>      >     > >       hw/mips/malta: Register the machine as a TypeInfo
>      >     > >       hw/mips/malta: Rename 'malta' machine as 'malta-virt'
>      >     > >       hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>      >     > >       hw/mips/malta: Introduce the 'malta-phys' machine
>      >     > >       hw/mips/malta: Verify malta-phys machine uses
>     correct DIMM
>      >     sizes
>      >     > >       hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
>      >     > >
>      >     > >      hw/mips/malta.c | 121
>      >     +++++++++++++++++++++++++++++++++++++++---------
>      >     > >      1 file changed, 99 insertions(+), 22 deletions(-)
>      >     > >
>      >     > >     --
>      >     > >
>      >     > >
>      >     > >
>      >     > > Thank you, Philippe, for providing this series.
>      >     > >
>      >     > > However, in previous discussion on the patch you mention
>     above, I
>      >     > > already expressed serious reservations on the approach
>     taken in that
>      >     > > patch. These reservations stay today too.
>      >     > >
>      >     > > There is nothing qualitatively different between the original
>      >     patch and
>      >     > > this series. Naming and related stuff are just cosmetic
>     issues.
>      >     >
>      >     > OK, what about considering all patches except the last one?
>      >     > So we can run firmware on a real Malta board, not the QEMU
>      >     > imaginary one (in the discussion you said QEMU should respect
>      >     > real hardware, which I agree).
>      >     >
>      >     > >
>      >     > > The good thing about this series is that one can apply it
>      >     dowstream, if
>      >     > > one finds it useful. However, it is not suitable for
>     upstreaming
>      >
>      >     IOW, what is missing to have this series (except the last patch)
>      >     accepted upstream?
>      >
>      >
>      > It is not what is missing, but was already is in the series that
>     makes
>      > it not suitable for upstreaming. The very concept of the series is
>      > problematic.
> 
>     What is the series is not suitable for upstream? Can you point to
>     patch and code please? How would you conceptually resolve the
>     problem?
> 
> 
> The answer is already in the original thread on the original patch.
> 
> The problem is artificialy imposed:
> 
> One needs a feature not present in the physical system. The solution is 
> not in creating "virtual" upgrade - this violates the basic foundation 
> if QEMU.
> 
> If the feature is missing, the optimal solution would be emulating the 
> physical solution that has that feature.
> 
> In some rare cases (that should be avoided as mush as possible), and for 
> really good reasons, we can create an emulation of some imagined 
> hardware that was never designed let alone built - there are a couple of 
> examples in other targets.
> 
> But extending the emulation of existing physical system with 
> non-existing features is not acceptable.

Interesting statement. I suggest to include the following patch in your 
next mips pull request to avoid that mips users spoil their machines 
with virtual-only features:

diff a/default-configs/mips-softmmu-common.mak 
b/default-configs/mips-softmmu-common.mak
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -6,10 +6,10 @@ CONFIG_SEMIHOSTING=y
  CONFIG_ISA_BUS=y
  CONFIG_PCI=y
  CONFIG_PCI_DEVICES=y
+CONFIG_VIRTIO_PCI=n
  CONFIG_VGA_ISA=y
  CONFIG_VGA_ISA_MM=y
  CONFIG_VGA_CIRRUS=y
-CONFIG_VMWARE_VGA=y
  CONFIG_SERIAL=y
  CONFIG_SERIAL_ISA=y
  CONFIG_PARALLEL=y

;-)

No, seriously, as far as I can tell, QEMU was never in that "we strictly 
only emulate real hardware" camp, even the homepage talks about 
"virtualizer".

But introducing a separate machine for this feature sounds a little bit 
excessive for me, too. What about introducing a machine property for the 
max-ram-size? With the default value, the machine could restrict the ram 
sizes to the values that are possible with the real hardware, and only 
if the (advanced) user tweaks the property, it would be possible to set 
bigger values. Just my 0.02 €.

  Thomas


PS: Why does mips use CONFIG_VMWARE_VGA=y at all? Is VMWARE also 
available for mips?

PPS: Why is mips still not using proper Kconfig settings yet?


