Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BC42073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BC42073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKc8-0002SZ-D0
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1jKKbJ-0001lz-PQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1jKKbI-0007ml-Cs
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:35:05 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:4039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1jKKbG-0007Z5-2c; Fri, 03 Apr 2020 07:35:02 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id F05D1434A5;
 Fri,  3 Apr 2020 13:34:55 +0200 (CEST)
Date: Fri, 03 Apr 2020 13:34:53 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
 <57b3d155-148c-6eb4-c969-825aeb9ff293@redhat.com>
In-Reply-To: <57b3d155-148c-6eb4-c969-825aeb9ff293@redhat.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585913299.ocu8z6q1n7.astroid@nora.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On February 25, 2020 10:54 pm, John Snow wrote:
> On 2/18/20 5:07 AM, Fabian Gr=C3=BCnbichler wrote:
>> picking up on John's in-progress patch series from last summer, this is
>> a stab at rebasing and adding test cases for the low-hanging fruits:
>>=20
>> - bitmap mirror mode with always/on-success/never bitmap sync mode
>> - incremental mirror mode as sugar for bitmap + on-success
>>=20
>> Fabian Gr=C3=BCnbichler (4):
>>   mirror: add check for bitmap-mode without bitmap
>>   mirror: switch to bdrv_dirty_bitmap_merge_internal
>>   iotests: add test for bitmap mirror
>>   mirror: move some checks to QMP
>>=20
>> John Snow (2):
>>   drive-mirror: add support for sync=3Dbitmap mode=3Dnever
>>   drive-mirror: add support for conditional and always bitmap sync modes
>>=20
>>  include/block/block_int.h   |    4 +-
>>  block/mirror.c              |   96 +-
>>  blockdev.c                  |   71 +-
>>  tests/test-block-iothread.c |    4 +-
>>  qapi/block-core.json        |   29 +-
>>  tests/qemu-iotests/284      |  547 +++++++
>>  tests/qemu-iotests/284.out  | 2846 +++++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/group    |    1 +
>>  8 files changed, 3567 insertions(+), 31 deletions(-)
>>  create mode 100755 tests/qemu-iotests/284
>>  create mode 100644 tests/qemu-iotests/284.out
>>=20
>=20
> Hi Fabian! Thanks for picking this up. I'm a bit behind on my mail, but
> this on my list to look at.
>=20
> (Hint to other maintainers: It might be a while.)
>=20
> --js

Hi,

ping? ;)

(it would be great to get some feedback as we'd like to ship this=20
backported to 4.2 or 5.0 with our next point release)

kind regards,
Fabian
=


