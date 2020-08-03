Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5651BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0678F2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbtLTT2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0678F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2U8T-00026N-UL
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 02:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1k2U7l-0001g2-TQ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 02:39:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1k2U7j-0008F5-6J
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 02:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596436741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2m2FD/AfxRQQ8cFCRL4kHNJAr1+u084GZwhVNlVvIdU=;
 b=KbtLTT2ik7uPz0d8oZzohRVBnczN0evlOP1o3OHIQi9BY7g1xhRPVDrDz7tujcjMnNio1Q
 325uCK08QqnmmLV/VhfgCHQ/AAFBKRzmMoJ+j37TCPoImmjkvCyseCjWB1cuGFO3743ZdV
 0JNhM5HUMslje5C06HVygB4DfTrOPEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-9niuUIecPey711nwC0a8vA-1; Mon, 03 Aug 2020 02:37:41 -0400
X-MC-Unique: 9niuUIecPey711nwC0a8vA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C464519253C3;
 Mon,  3 Aug 2020 06:37:40 +0000 (UTC)
Received: from [10.35.206.146] (unknown [10.35.206.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6998B8AD1C;
 Mon,  3 Aug 2020 06:37:38 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Bug 1889943] Improper TCP/IP packet splitting on e1000e/vmxnet3
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <159638395025.2765.10598480128444699560.malone@gac.canonical.com>
Date: Mon, 3 Aug 2020 09:37:36 +0300
Message-Id: <7C05EECD-F47B-4314-8FB0-D5C9C69A8BB9@redhat.com>
References: <159622949743.5060.8912306868276612545.malonedeb@soybean.canonical.com>
 <159638395025.2765.10598480128444699560.malone@gac.canonical.com>
To: Bug 1889943 <1889943@bugs.launchpad.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 01:24:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Melnichenko <andrew@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Patrick,

If you are using  QEMU version 4.2, then it is missing recent patches fixin=
g IPv6 and TSO behaviour:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg723411.html
https://www.mail-archive.com/qemu-devel@nongnu.org/msg723412.html

Can you check that the above patches solve your issues?


Best regards,
Yan.

> On 2 Aug 2020, at 6:59 PM, Patrick Magauran <1889943@bugs.launchpad.net> =
wrote:
>=20
> Some more clarifications:
> It appears the QEMU does turn on the vnet_hdr flag of the tap interface i=
n most cases, not just host-only networks. My previous assumption was due t=
o the way the libvirt manages it, only setting it if the virtio interface i=
s used.
>=20
> Still, for software fragmentation implementations, ip fragmentation
> should be a last resort.
>=20
> I have also confirmed a suspicion that the current implementation of sw
> fragmentation will not work with IPV6. It creates malformed packets as
> ipv6 requires a different setup of headers to fragment. Thanks to the
> many redundancies in the network stack, the packets eventually arrive at
> the host server correctly formed, but we should not rely on this fact.
>=20
> ** Description changed:
>=20
> + Update: The sw implementation of fragmentation also creates malformed
> + IPv6 packets when their size is above the MTU. See comment #3
> +=20
>  Problem Description:
> - When using a tap interface and the guest sends a TCP packet that would =
need to be segmented, it is fragmented using IP fragmentation. The host doe=
s not reassemble the IP fragments and forwards them to the next hop. This c=
auses issues on certain ISPs, which seemingly reject IP fragments(Verizon F=
ios).=20
> - This issue occurs on the e1000e and vmxnet3 NIC models, and possibly ot=
hers. It does not occur on the virtio(which passes the entire packet throug=
h to the host w/o fragmentation or segmentation) or the e1000 model().=20
> + When using a tap interface and the guest sends a TCP packet that would =
need to be segmented, it is fragmented using IP fragmentation. The host doe=
s not reassemble the IP fragments and forwards them to the next hop. This c=
auses issues on certain ISPs, which seemingly reject IP fragments(Verizon F=
ios).
> + This issue occurs on the e1000e and vmxnet3 NIC models, and possibly ot=
hers. It does not occur on the virtio(which passes the entire packet throug=
h to the host w/o fragmentation or segmentation) or the e1000 model().
>=20
>  Test scenario:
>  Setup a tap and network bridge using the directions here: https://gist.g=
ithub.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d811c
>  Boot the machine into any modern guest(a Fedora 31 live iso was used for=
 testing)
>  Begin a wireshark capture on the host machine
>  On the host(or another machine on the network) run: npx http-echo-server=
(See https://github.com/watson/http-echo-server)
>  On the guest run
>  Curl -d =E2=80=9CLorem ipsum dolor sit amet, consectetur adipiscing elit=
. Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu. Suspendiss=
e vehicula congue ante, non rhoncus elit tempus vitae. Duis ac leo massa. D=
onec rutrum condimentum turpis nec ultricies. Duis laoreet elit eu arcu pul=
vinar, vitae congue neque mattis. Mauris sed ante nunc. Vestibulum vitae ur=
na a tellus maximus sagittis. Vivamus luctus pellentesque neque, vel tempor=
 purus porta ut. Phasellus at quam bibendum, fermentum libero sit amet, ull=
amcorper mauris. In rutrum sit amet dui id maximus. Ut lectus ligula, hendr=
erit nec aliquam non, finibus a turpis. Proin scelerisque convallis ante, e=
t pharetra elit. Donec nunc nisl, viverra vitae dui at, posuere rhoncus nib=
h. Mauris in massa quis neque posuere placerat quis quis massa. Donec quis =
lacus ligula. Donec mollis vel nisi eget elementum. Nam id magna porta nunc=
 consectetur efficitur ac quis lorem. Cras faucibus vel ex porttitor mattis=
. Praesent in mattis tortor. In venenatis convallis quam, in posuere nibh. =
Proin non dignissim massa. Cras at mi ut lorem tristique fringilla. Nulla a=
c quam condimentum metus tincidunt vulputate ut at leo. Nunc pellentesque, =
nunc vel rhoncus condimentum, arcu sem molestie augue, in suscipit mauris o=
dio mollis odio. Integer hendrerit lectus a leo facilisis, in accumsan urna=
 maximus. Nam nec odio volutpat, varius est id, tempus libero. Vestibulum l=
obortis tortor quam, ac scelerisque urna rhoncus in. Etiam tempor, est sit =
amet vulputate molestie, urna neque sodales leo, sit amet blandit risus fel=
is sed est. Nulla eu eros nec tortor dapibus maximus faucibus ut erat. Ut p=
haretra tempor massa in bibendum. Interdum et malesuada fames ac ante ipsum=
 primis in faucibus. Etiam mattis molestie felis eu efficitur. Morbi tincid=
unt consectetur diam tincidunt feugiat. Morbi euismod ut lorem finibus pell=
entesque. Aliquam eu porta ex. Aliquam cursus, orci sit amet volutpat egest=
as, est est pulvinar erat, sed luctus nisl ligula eget justo vestibulum.=E2=
=80=9D <ECHOSERVERIP:PORT>
>=20
>  2000 bytes of Lorem Ipsum taken from https://www.lipsum.com/
>=20
>  Compare results from an e1000, a virtio, and a e1000e card:
>  +--------+-----------+---------+------------+
>  | Model  | Fragment  | Segment | Wire Size  |
>  +--------+-----------+---------+------------+
>  | e1000e | Yes       | NO      | 1484 + 621 |
>  +--------+-----------+---------+------------+
>  | e1000  | No        | Yes     | 1516 + 620 |
>  +--------+-----------+---------+------------+
>  | Virtio | NO        | NO      | 2068       |
>  +--------+-----------+---------+------------+
>=20
>  Expected Results:
>  TCP Segment to proper size OR pass full size to host and let the host sp=
lit if necessary.
>=20
>  Configuration changes that did not work:
>  Disable host, guest, router firewalls
>  Different Hosts
>  Different Physical NICs
>  Libvirt based NAT/Routed modes
>  Fedora 32 vs 31
>  Qemu 4.2.0 vs github commit d74824cf7c8b352f9045e949dc636c7207a41eee
>=20
>  System Information:
>  lsb_release -rd
>  Description:=09Fedora release 32 (Thirty Two)
>  Release:=0932
>=20
>  uname -a
>  Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23 00:58:3=
9 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>=20
>  I can provide additional logs, debug info, etc. if needed.
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1889943
>=20
> Title:
>  Improper TCP/IP packet splitting on e1000e/vmxnet3
>=20
> Status in QEMU:
>  New
>=20
> Bug description:
>  Update: The sw implementation of fragmentation also creates malformed
>  IPv6 packets when their size is above the MTU. See comment #3
>=20
>  Problem Description:
>  When using a tap interface and the guest sends a TCP packet that would n=
eed to be segmented, it is fragmented using IP fragmentation. The host does=
 not reassemble the IP fragments and forwards them to the next hop. This ca=
uses issues on certain ISPs, which seemingly reject IP fragments(Verizon Fi=
os).
>  This issue occurs on the e1000e and vmxnet3 NIC models, and possibly oth=
ers. It does not occur on the virtio(which passes the entire packet through=
 to the host w/o fragmentation or segmentation) or the e1000 model().
>=20
>  Test scenario:
>  Setup a tap and network bridge using the directions here: https://gist.g=
ithub.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d811c
>  Boot the machine into any modern guest(a Fedora 31 live iso was used for=
 testing)
>  Begin a wireshark capture on the host machine
>  On the host(or another machine on the network) run: npx http-echo-server=
(See https://github.com/watson/http-echo-server)
>  On the guest run
>  Curl -d =E2=80=9CLorem ipsum dolor sit amet, consectetur adipiscing elit=
. Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu. Suspendiss=
e vehicula congue ante, non rhoncus elit tempus vitae. Duis ac leo massa. D=
onec rutrum condimentum turpis nec ultricies. Duis laoreet elit eu arcu pul=
vinar, vitae congue neque mattis. Mauris sed ante nunc. Vestibulum vitae ur=
na a tellus maximus sagittis. Vivamus luctus pellentesque neque, vel tempor=
 purus porta ut. Phasellus at quam bibendum, fermentum libero sit amet, ull=
amcorper mauris. In rutrum sit amet dui id maximus. Ut lectus ligula, hendr=
erit nec aliquam non, finibus a turpis. Proin scelerisque convallis ante, e=
t pharetra elit. Donec nunc nisl, viverra vitae dui at, posuere rhoncus nib=
h. Mauris in massa quis neque posuere placerat quis quis massa. Donec quis =
lacus ligula. Donec mollis vel nisi eget elementum. Nam id magna porta nunc=
 consectetur efficitur ac quis lorem. Cras faucibus vel ex porttitor mattis=
. Praesent in mattis tortor. In venenatis convallis quam, in posuere nibh. =
Proin non dignissim massa. Cras at mi ut lorem tristique fringilla. Nulla a=
c quam condimentum metus tincidunt vulputate ut at leo. Nunc pellentesque, =
nunc vel rhoncus condimentum, arcu sem molestie augue, in suscipit mauris o=
dio mollis odio. Integer hendrerit lectus a leo facilisis, in accumsan urna=
 maximus. Nam nec odio volutpat, varius est id, tempus libero. Vestibulum l=
obortis tortor quam, ac scelerisque urna rhoncus in. Etiam tempor, est sit =
amet vulputate molestie, urna neque sodales leo, sit amet blandit risus fel=
is sed est. Nulla eu eros nec tortor dapibus maximus faucibus ut erat. Ut p=
haretra tempor massa in bibendum. Interdum et malesuada fames ac ante ipsum=
 primis in faucibus. Etiam mattis molestie felis eu efficitur. Morbi tincid=
unt consectetur diam tincidunt feugiat. Morbi euismod ut lorem finibus pell=
entesque. Aliquam eu porta ex. Aliquam cursus, orci sit amet volutpat egest=
as, est est pulvinar erat, sed luctus nisl ligula eget justo vestibulum.=E2=
=80=9D <ECHOSERVERIP:PORT>
>=20
>  2000 bytes of Lorem Ipsum taken from https://www.lipsum.com/
>=20
>  Compare results from an e1000, a virtio, and a e1000e card:
>  +--------+-----------+---------+------------+
>  | Model  | Fragment  | Segment | Wire Size  |
>  +--------+-----------+---------+------------+
>  | e1000e | Yes       | NO      | 1484 + 621 |
>  +--------+-----------+---------+------------+
>  | e1000  | No        | Yes     | 1516 + 620 |
>  +--------+-----------+---------+------------+
>  | Virtio | NO        | NO      | 2068       |
>  +--------+-----------+---------+------------+
>=20
>  Expected Results:
>  TCP Segment to proper size OR pass full size to host and let the host sp=
lit if necessary.
>=20
>  Configuration changes that did not work:
>  Disable host, guest, router firewalls
>  Different Hosts
>  Different Physical NICs
>  Libvirt based NAT/Routed modes
>  Fedora 32 vs 31
>  Qemu 4.2.0 vs github commit d74824cf7c8b352f9045e949dc636c7207a41eee
>=20
>  System Information:
>  lsb_release -rd
>  Description:=09Fedora release 32 (Thirty Two)
>  Release:=0932
>=20
>  uname -a
>  Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23 00:58:3=
9 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>=20
>  I can provide additional logs, debug info, etc. if needed.
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1889943/+subscriptions
>=20


