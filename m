Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427C2C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBC020659
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+DoWLAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBC020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLBV-0003eM-7Q
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKLAo-0002y0-VU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKLAn-00019J-Kv
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:11:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKLAn-00018y-HX
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585915904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfdTfvDUv23qMYCSGI1OMfdr0FySXplZrnoSM0uzGoM=;
 b=b+DoWLAwCRXNBmmHDvEGkaXi+aMvmdGQZpbzigGa0oHcuQepMuli1GpPf3qjteup6aK6DA
 Ld/rYrw+uzltWs09KQr3E9726kWfjlD17jtxrTYlGN63YhnLyQzVcfWLLY85yhYd3MEwbM
 OZ1nuh1oKrzZHmIcPoP5n1GHuFh+yMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-i-CgseA1PyKvsOd7iR2NZQ-1; Fri, 03 Apr 2020 08:11:41 -0400
X-MC-Unique: i-CgseA1PyKvsOd7iR2NZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 331E71005509;
 Fri,  3 Apr 2020 12:11:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD02E10016E8;
 Fri,  3 Apr 2020 12:11:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99C1B11385E2; Fri,  3 Apr 2020 14:11:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: Qemu doesn't detect hard drive
References: <XSF-9CLAGYMG1ivdwoihQBZm3XT2vWdKVqHtMLExgA1LJwkSeISDoKKVEJ3E3qhZaNvki44j2CdXdQ81ljytvtS0MGmXL3gFhO2kQmWA2Kk=@protonmail.com>
 <CAFEAcA_-aRethWOmzaKqft8yMg6dGUUwvf1kX36R4+R=yWS2RA@mail.gmail.com>
 <5c877825-dbf0-295e-20b7-6949e15be745@redhat.com>
Date: Fri, 03 Apr 2020 14:11:38 +0200
In-Reply-To: <5c877825-dbf0-295e-20b7-6949e15be745@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Apr 2020 13:07:37
 +0200")
Message-ID: <87d08opy4l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 "Aijaz.Baig" <Aijaz.Baig@protonmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/3/20 9:39 AM, Peter Maydell wrote:
>> On Fri, 3 Apr 2020 at 06:18, Aijaz.Baig <Aijaz.Baig@protonmail.com> wrot=
e:
>>> I would now like to add a hard disk for persistent storage and then tra=
nsfer control from busybox initrd based rootfs over to the full fledged ver=
sion offered with Linux. So I add it to the command line
>>>
>>> `sudo qemu-system-arm -m 1024M -M vexpress-a9 -D qemu.log -drive if=3Dn=
one,format=3Draw,file=3Ddisk.img -kernel buildroot-2019.02.5/output/images/=
zImage -dtb buildroot-2019.02.5/output/images/vexpress-v2p-ca9.dtb -append =
"console=3DttyAMA0,115200 kgdboc=3Dkbd,ttyAMA0,115200 ip=3Ddhcp nokaslr" -i=
nitrd buildroot-2019.02.5/output/images/rootfs.cpio -nographic -net nic -ne=
t bridge,br=3Dmybridge -s
>>
>> This command line creates a "drive" object but doesn't plug it in to any=
thing
>> (it's like asking QEMU to model a board, with a hard drive sat next to i=
t
>> on the desk but no cable between them :-))
>
> Should QEMU warn the user about unplugged drives?
>
> Or is it an expected feature (these drives might be hot-plugged later?)

For what it's worth, it warns about unused network backends, but not
about unused block or character backends.  All of them can be connected
later in the monitor.


