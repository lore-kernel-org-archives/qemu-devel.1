Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356BFC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C222071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5fHbaOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C222071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgRh-0004Sj-65
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRgQc-0002sc-Be
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRgQa-00010h-SW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:18:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRgQa-0000xq-FA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587665903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xtdrzsF04zvBFlNFveofitFAjCVODi73AWwr6171FA=;
 b=M5fHbaOPC8T/IgW4zPUvYeJnb9DC/n01qc2ZwRYHtqvtKAyj60jqE93cVH3JHftieyrA2j
 x/157ZqvBuFJ+mdYLFdwm3w6gS6LZjhiEAWJrBRmuKWhq1nxfl+wxwQowoYGTcipknzfUy
 iz1UQJqb6YzVT1SynrYCmV7FsEwf5yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-rW-P051YOVuxgQjDd9RoNQ-1; Thu, 23 Apr 2020 14:18:19 -0400
X-MC-Unique: rW-P051YOVuxgQjDd9RoNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D15800FC7;
 Thu, 23 Apr 2020 18:18:18 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 948776084C;
 Thu, 23 Apr 2020 18:18:17 +0000 (UTC)
Subject: Re: [PATCH 10/13] qapi: Clean up visitor's recovery from input with
 invalid type
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200423160036.7048-1-armbru@redhat.com>
 <20200423160036.7048-11-armbru@redhat.com>
 <435f2d5d-e732-a236-bf13-991d5c3510e6@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <89636246-6a5c-476d-6016-977f39cb653c@redhat.com>
Date: Thu, 23 Apr 2020 13:18:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <435f2d5d-e732-a236-bf13-991d5c3510e6@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 1:06 PM, Eric Blake wrote:
> On 4/23/20 11:00 AM, Markus Armbruster wrote:
>> An alternate type's visit_type_FOO() fails when it runs into an
>> invalid ->type.=C2=A0 If it's an input visit, we then need to free the t=
he
>> object we got from visit_start_alternate().=C2=A0 We do that with
>> qapi_free_FOO(), which uses the dealloc visitor.
>>
>> Trouble is that object is in a bad state: its ->type is invalid.=C2=A0 S=
o
>> the dealloc visitor will run into the same error again, and the error
>> recovery skips deallocating the alternate's (invalid) alternative.
>> This is a roundabout way to g_free() the alternate.
>>
>> Simplify: replace the qapi_free_FOO() by g_free().
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> =C2=A0 scripts/qapi/visit.py | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>=20
> Required looking at what gets generated into qapi_free_FOO() as well as=
=20
> when visit_start_alternate() can fail, but makes sense.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Actually, I'm having second thoughts.  As an example, look at the generated=
:

> void visit_type_BlockDirtyBitmapMergeSource(Visitor *v, const char *name,=
 BlockDirtyBitmapMergeSource **obj, Error **errp)
> {
>     Error *err =3D NULL;
>=20
>     visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**obj=
),
>                           &err);
>     if (err) {
>         goto out;
>     }
>     if (!*obj) {
>         goto out_obj;
[1]
>     }
>     switch ((*obj)->type) {
>     case QTYPE_QSTRING:
>         visit_type_str(v, name, &(*obj)->u.local, &err);
[2]
>         break;
>     case QTYPE_QDICT:
>         visit_start_struct(v, name, NULL, 0, &err);
>         if (err) {
>             break;
[3]
>         }
>         visit_type_BlockDirtyBitmap_members(v, &(*obj)->u.external, &err)=
;
>         if (!err) {
>             visit_check_struct(v, &err);
[4]
>         }
>         visit_end_struct(v, NULL);
>         break;
>     case QTYPE_NONE:
>         abort();
>     default:
>         error_setg(&err, QERR_INVALID_PARAMETER_TYPE, name ? name : "null=
",
>                    "BlockDirtyBitmapMergeSource");
[5]
>     }
> out_obj:
>     visit_end_alternate(v, (void **)obj);
>     if (err && visit_is_input(v)) {
>         qapi_free_BlockDirtyBitmapMergeSource(*obj);

If we got here, we must have failed at any of the points mentioned above.

If [1], visit_start_alternate() failed, but *obj is NULL and both=20
qapi_free_FOO(NULL) and g_free(NULL) are safe.

If [2], visit_type_str() failed, so *obj is allocated but the embedded=20
string (here, u.local) was left NULL.  qapi_free_FOO() then does nothing=20
further than g_free(obj).

If [3], visit_start_struct() failed, the embedded dict (here,=20
u.external) was left NULL.  qapi_free_FOO() then does nothing further=20
than g_free(obj).

If [5], we have the wrong ->type.  As pointed out by this commit,=20
qapi_free_FOO() does nothing further than g_free(obj).

But what happens in [4]?  Here, the embedded dict was allocated, but we=20
then failed while parsing its members.  That leaves us in a=20
partially-allocated state, and g_free(NULL) does NOT recursively visit=20
that partial allocation.  I think this patch is prone to a memory leak=20
unless you _also_ patch things to free any dict branch on failure=20
(perhaps during the QTYPE_QDICT case label, rather than here at the end).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


