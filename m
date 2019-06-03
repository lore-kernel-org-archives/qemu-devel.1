Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0006DC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEA327BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEA327BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgVI-0002QT-Ru
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 02:31:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1hXgUP-00025K-K1
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1hXgUO-0003p3-Hy
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:30:37 -0400
Received: from david.siemens.de ([192.35.17.14]:42435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1hXgUO-0003h8-88
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:30:36 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x536UVxp002701
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); 
	Mon, 3 Jun 2019 08:30:31 +0200
Received: from [167.87.8.96] ([167.87.8.96])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x536UT8X028759;
	Mon, 3 Jun 2019 08:30:29 +0200
To: Peter Xu <peterx@redhat.com>
References: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
	<20190602121014.GC4958@xz-x1>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0fa8967b-ccee-4478-35fc-3c60524b316a@siemens.com>
Date: Mon, 3 Jun 2019 08:30:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
	Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190602121014.GC4958@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 192.35.17.14
Subject: Re: [Qemu-devel] [PATCH] ioapic: kvm: Skip route updates for masked
 pins
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.06.19 14:10, Peter Xu wrote:
> On Sun, Jun 02, 2019 at 01:42:13PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Masked entries will not generate interrupt messages, thus do no need to
>> be routed by KVM. This is a cosmetic cleanup, just avoiding warnings of
>> the kind
>>
>> qemu-system-x86_64: vtd_irte_get: detected non-present IRTE (index=0, high=0xff00, low=0x100)
>>
>> if the masked entry happens to reference a non-present IRTE.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Thanks, Jan.
> 
> The "non-cosmetic" part of clearing of those entries (e.g. including
> when the entries were not setup correctly rather than masked) was
> never really implemented and that task has been on my todo list for
> quite a while but with a very low priority (low enough to sink...).  I
> hope I didn't overlook its importance since AFAICT general OSs should
> hardly trigger those paths and so far I don't see it a very big issue.

I triggered the message during the handover phase from Linux to Jailhouse. That 
involves reprogramming both IOAPIC and IRTEs - likely unusual sequences, I just 
didn't find invalid ones.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

