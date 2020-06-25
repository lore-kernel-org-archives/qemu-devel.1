Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F05206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFbhNEUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F05206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRBB-00014R-Vb
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joR9r-0007mG-1H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:39:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joR9o-0004dp-OA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593088747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9BAQc5dYbqe98OTUnXfgXPkwj7KNo1Txuaf7qWZklY=;
 b=VFbhNEUEsmDDH4aqz2G9Ry9O1yCX6iQq3OUYQ8VRYxRReppugJjpjkjQwfZrCOHbef1o1A
 wNNKYL86OBKA0jHsz5XFXXLfG7H2NcSW9032zx890xk+g6f2cxZpq71OMyebj8xwueQc4U
 Op7uncmeg4vF1YhCgsXWMZtnXBEXs1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-GIDxmNXgN9CuICrjVoAFXA-1; Thu, 25 Jun 2020 08:39:05 -0400
X-MC-Unique: GIDxmNXgN9CuICrjVoAFXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A280B107ACCA;
 Thu, 25 Jun 2020 12:39:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18DE87FE8B;
 Thu, 25 Jun 2020 12:39:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96E2611384D4; Thu, 25 Jun 2020 14:39:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 06/46] error: Avoid error_propagate() when error is not
 used here
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-7-armbru@redhat.com>
 <415efae8-9624-7d7d-b4af-f6a019e345f9@redhat.com>
Date: Thu, 25 Jun 2020 14:39:02 +0200
In-Reply-To: <415efae8-9624-7d7d-b4af-f6a019e345f9@redhat.com> (Eric Blake's
 message of "Wed, 24 Jun 2020 13:17:08 -0500")
Message-ID: <87pn9n1frt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 6/24/20 11:43 AM, Markus Armbruster wrote:
>> When all we do with an Error we receive into a local variable is
>> propagating to somewhere else, we can just as well receive it there
>> right away.  Coccinelle script:
>
> This seems to be a recurring cleanup (witness commit 06592d7e,
> c0e90679, 6b62d961).  In fact, shouldn't you just update that script
> with your enhancements here, and then run it directly, instead of
> embedding your tweaks in the commit message?

I didn't remember scripts/coccinelle/remove_local_err.cocci.

remove_local_err.cocci transforms

    fun(..., &err);
    error_propagate(errp, err);

to

    fun(..., errp);

when the context permits that, using a conservative approximation of
"context permits".  In other words, the script is sound.

My script matches more, but is unsound: it *can* mess up things.  For
instance

    Error err = NULL;

    foo(1, 2, 3, &err);
    error_propagate(errp, err);
    return !err;

would become

    Error err = NULL;

    foo(1, 2, 3, errp);
    return !err;

Oops.  See "manually double-check" below.  For a one-shot cleanup,
manual checking is much, much easier for me than making the Coccinelle
script sound without sacrificing (too much) matching power.

>
>>
>>      @@
>>      identifier fun, err, errp;
>>      expression list args;
>>      @@
>>      -    fun(args, &err);
>>      +    fun(args, errp);
>>           ... when != err
>>               when strict
>>      -    error_propagate(errp, err);
>
> What does the 'when strict' accomplish?  The existing coccinelle
> script uses 'when != errp', which may be enough to address...

Magic!  Without it, I get

   diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
   index 8310c77ec0..2355999171 100644
   --- a/hw/vfio/pci.c
   +++ b/hw/vfio/pci.c
   @@ -1511,16 +1511,14 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
        ret = msix_init(&vdev->pdev, vdev->msix->entries,
                        vdev->bars[vdev->msix->table_bar].mr,
                        vdev->msix->table_bar, vdev->msix->table_offset,
   -                    vdev->bars[vdev->msix->pba_bar].mr,
   -                    vdev->msix->pba_bar, vdev->msix->pba_offset, pos,
   -                    &err);
   +                    vdev->bars[vdev->msix->pba_bar].mr, vdev->msix->pba_bar,
   +                    vdev->msix->pba_offset, pos, errp);
        if (ret < 0) {
            if (ret == -ENOTSUP) {
WTF!?! --->     warn_report_err(err);
                return 0;
            }

   -        error_propagate(errp, err);
            return ret;
        }

Since Coccinelle's documentation is of no help whatsoever (again), I
went looking for possibly applicable ideas in existing scripts.  I found
"when strict" in the kernel's scripts/coccinelle/ directory.  I couldn't
find it in Coccinelle docs.  So I gave it a try, and here we are.

Did I mention Coccinelle is terrible?

>> The first two rules are prone to fail with "error_propagate(...)
>> ... reachable by inconsistent control-flow paths".  Script without
>> them re-run where that happens.
>
> ...the control-flow failures you hit?

This one I can actually explain, I think.  Consider this code snippet
from net.c:

 1      visit_type_Netdev(v, NULL, &object, &err);

 2      if (!err) {
 3          ret = net_client_init1(object, is_netdev, &err);
 4      }

 5      qapi_free_Netdev(object);

 6  out:
 7      error_propagate(errp, err);

There are two overlapping matches of rule 1: either line 1 and 7, or
line 3 and 7.  Which one is right?  Coccinelle can't decide, and
implodes:

    rule starting on line 10: node 96: error_propagate(...)[1,2,41,42] in net_client_init reachable by inconsistent control-flow paths

>>
>> Manually double-check @err is not used afterwards.  Dereferencing it
>> would be use after free, but checking whether it's null would be
>> legitimate.  One such change to qbus_realize() backed out.
>>
>> Suboptimal line breaks tweaked manually.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>   22 files changed, 31 insertions(+), 73 deletions(-)
>
> At any rate, it's small enough to ensure all the changes remaining are
> still valid.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


