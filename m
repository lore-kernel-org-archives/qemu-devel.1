Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C99C433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDF0206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXOuWK4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDF0206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RW6-00058q-5S
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1k0RVU-0004gN-KM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:27:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1k0RVS-0002NJ-35
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595950023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=ltfCSGcwjCF9FHJXyPIcobo/0HRf+COmOapKBlwjB84=;
 b=FXOuWK4qLVFMtp2Ry4PKps1O3S+wzjKKjDq+9+MZCBs9/kDC6Quu2x6DoO1DKqvVlk8Yxc
 NB+evNTgkgjY/Ysi3zrOk9CSGHOuPqUeq7K3CFXSjuaeY7IR1aBYCaG7N9xDw7ywMe7zlY
 diyCwqx80ZVRS1wA6IyDlUjCFWS3rJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-1l03zenJP-WxrQevVudz-w-1; Tue, 28 Jul 2020 11:27:01 -0400
X-MC-Unique: 1l03zenJP-WxrQevVudz-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C44561009461
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 15:27:00 +0000 (UTC)
Received: from titinator (ovpn-114-132.ams2.redhat.com [10.36.114.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A6275559
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 15:26:59 +0000 (UTC)
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: Missing qapi_free_Type in error case for qapi generated code?
Date: Tue, 28 Jul 2020 17:26:57 +0200
Message-ID: <ly4kprhd8e.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qapi generated code for qmp_marshal_query_spice seems to be missing a
resource deallocation for "retval". For example, for SpiceInfo:

#if defined(CONFIG_SPICE)
void qmp_marshal_query_spice(QDict *args, QObject **ret, Error **errp)
{
    Error *err = NULL;
    bool ok = false;
    Visitor *v;
    SpiceInfo *retval;

    v = qobject_input_visitor_new(QOBJECT(args));
    if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
        goto out;
    }
    ok = visit_check_struct(v, errp);
    visit_end_struct(v, NULL);
    if (!ok) {
        goto out;
    }

    retval = qmp_query_spice(&err);
    error_propagate(errp, err);
    if (err) {
/* retval not freed here */
/* Missing: qapi_free_SpiceInfo(retval); */
        goto out;
    }

    qmp_marshal_output_SpiceInfo(retval, ret, errp);

out:
    visit_free(v);
    v = qapi_dealloc_visitor_new();
    visit_start_struct(v, NULL, NULL, 0, NULL);
    visit_end_struct(v, NULL);
    visit_free(v);
}
#endif /* defined(CONFIG_SPICE) */

Questions:

- Is the query code supposed to always return NULL in case of error? In the
  case of hmp_info_spice, there is no check for info==NULL, so on the
  contrary, it seems to indicate that a non-null result is always expected,
  and that function does call qapi_free_SpiceInfo

- If not, is there an existing shortcut to generate the correct deallocation
  code for return types that need it? You can't just use
  qapi_free_%(c_type)s because that would generate an extra * character,
  i.e. I get "SpiceInfo *" and not "SpiceInfo".

- If not, is there any good way to know if the type is a pointer type?
  (A quick look in cripts/qapi/types.py does not show anything obvious)

--
Cheers,
Christophe de Dinechin (IRC c3d)


