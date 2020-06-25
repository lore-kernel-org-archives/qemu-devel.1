Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436EBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106CE2081A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U48/DXrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106CE2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSEe-0003lQ-8P
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joSDY-000358-Q4
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:47:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joSDW-0003WL-25
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593092820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDIwMTVRT52x4W2Uaeylz1cEkDeMz5P1cJSahXq/o8w=;
 b=U48/DXrrSF6R+UneMTbpmITj91/kNKs3ueL/jT2/zUC8e9fHqpuL9kgPzIosAP4EJ+CpsC
 t65M/Ph9yqwvgUeyPulZZQ8S7snuuPOwMB0qn0T3jwo0BrlZyJZT5TxT4AHgjrnpqJDcuW
 C8t1V9PX8VKd+AAo20nQi5n9IncrXL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-ri1qqq-zPh65qdeZHNCGAQ-1; Thu, 25 Jun 2020 09:46:58 -0400
X-MC-Unique: ri1qqq-zPh65qdeZHNCGAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCDC38015CB;
 Thu, 25 Jun 2020 13:46:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A4475DD61;
 Thu, 25 Jun 2020 13:46:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8C0811384D4; Thu, 25 Jun 2020 15:46:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 18/46] qemu-option: Smooth error checking manually
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-19-armbru@redhat.com>
 <09ff9918-ac64-e9cc-96b3-b0e4aed5800f@redhat.com>
Date: Thu, 25 Jun 2020 15:46:55 +0200
In-Reply-To: <09ff9918-ac64-e9cc-96b3-b0e4aed5800f@redhat.com> (Eric Blake's
 message of "Wed, 24 Jun 2020 15:10:47 -0500")
Message-ID: <87bll7z29c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
>> When foo(..., &err) is followed by error_propagate(errp, err), we can
>> often just as well do foo(..., errp).  The previous commit did that
>> for simple cases with Coccinelle.  Do it for a few more manually.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   block.c             | 2 +-
>>   block/gluster.c     | 8 ++++----
>>   block/parallels.c   | 2 +-
>>   block/quorum.c      | 2 +-
>>   block/replication.c | 2 +-
>>   block/vxhs.c        | 4 ++--
>>   hw/net/virtio-net.c | 4 ++--
>>   7 files changed, 12 insertions(+), 12 deletions(-)
>>
>
>> +++ b/block/gluster.c
>> @@ -523,7 +523,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>>         /* create opts info from runtime_json_opts list */
>>       opts = qemu_opts_create(&runtime_json_opts, NULL, 0, &error_abort);
>> -    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
>> +    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
>>           goto out;
>>       }
>
> This function also has a few error_setg(&local_err) that could be
> cleaned up to error_setg(errp);

More elsewhere.  PATCH 08 transforms them only where it permits deleting
the error_propagate().  I left the remainder for another day.  Not all
of them can be transformed more or less mechanically, e.g. this one in
mirror.c:

        if (bdrv_recurse_can_replace(src, to_replace)) {
            bdrv_replace_node(to_replace, target_bs, &local_err);
        } else {
            error_setg(&local_err, "Can no longer replace '%s' by '%s', "
                       "because it can no longer be guaranteed that doing so "
                       "would not lead to an abrupt change of visible data",
                       to_replace->node_name, target_bs->node_name);
        }
        bdrv_drained_end(target_bs);
        if (local_err) {
            error_report_err(local_err);
            ret = -EPERM;
        }

>                                 but the ones that use
> error_append_hint() immediately after (and thus the
> error_propagate(errp, local_err) in the out: label) still have to
> remain, until we have Vladimir's macro in place.

Correct.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


