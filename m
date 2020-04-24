Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7270AC5518A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E61020704
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxnSRl/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E61020704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRt1o-0003MK-6p
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 03:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRt15-0002iP-71
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRt14-0002eA-3q
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:44:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRt13-0002Yr-MU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587714292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppLUh3Zl8sPT7uzTTDsNRZJ8jHus4Yp+pGzZoJ3KiSA=;
 b=CxnSRl/SfVmzTEQrczKxbeeXiWhkACTKV/Rt9Fqd/VHyw9ke83edIHXeDZ0APaa8EuVyjh
 OoXxP4+J+YZJxGyWtW/jyFQ21Z3ywy14O6oXYqG4c7qC4tH+64Z+clHRNm2tuvlz75YtNt
 C97LK+9+uXHkrIwY9R1PXdSaAsxB1zY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-zaey1S39Ouuvv2ct2t4s8A-1; Fri, 24 Apr 2020 03:44:48 -0400
X-MC-Unique: zaey1S39Ouuvv2ct2t4s8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2F551800D51;
 Fri, 24 Apr 2020 07:44:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61227600EF;
 Fri, 24 Apr 2020 07:44:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D602911358BC; Fri, 24 Apr 2020 09:44:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 10/13] qapi: Clean up visitor's recovery from input with
 invalid type
References: <20200423160036.7048-1-armbru@redhat.com>
 <20200423160036.7048-11-armbru@redhat.com>
 <435f2d5d-e732-a236-bf13-991d5c3510e6@redhat.com>
 <89636246-6a5c-476d-6016-977f39cb653c@redhat.com>
Date: Fri, 24 Apr 2020 09:44:45 +0200
In-Reply-To: <89636246-6a5c-476d-6016-977f39cb653c@redhat.com> (Eric Blake's
 message of "Thu, 23 Apr 2020 13:18:04 -0500")
Message-ID: <877dy5pbte.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/23/20 1:06 PM, Eric Blake wrote:
>> On 4/23/20 11:00 AM, Markus Armbruster wrote:
>>> An alternate type's visit_type_FOO() fails when it runs into an
>>> invalid ->type.=C2=A0 If it's an input visit, we then need to free the =
the
>>> object we got from visit_start_alternate().=C2=A0 We do that with
>>> qapi_free_FOO(), which uses the dealloc visitor.
>>>
>>> Trouble is that object is in a bad state: its ->type is invalid.=C2=A0 =
So
>>> the dealloc visitor will run into the same error again, and the error
>>> recovery skips deallocating the alternate's (invalid) alternative.
>>> This is a roundabout way to g_free() the alternate.
>>>
>>> Simplify: replace the qapi_free_FOO() by g_free().
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>> =C2=A0 scripts/qapi/visit.py | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
>> Required looking at what gets generated into qapi_free_FOO() as well
>> as when visit_start_alternate() can fail, but makes sense.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Actually, I'm having second thoughts.  As an example, look at the generat=
ed:
>
>> void visit_type_BlockDirtyBitmapMergeSource(Visitor *v, const char *name=
, BlockDirtyBitmapMergeSource **obj, Error **errp)
>> {
>>     Error *err =3D NULL;
>>
>>     visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**ob=
j),
>>                           &err);
>>     if (err) {
>>         goto out;
>>     }
>>     if (!*obj) {
>>         goto out_obj;
> [1]
>>     }
>>     switch ((*obj)->type) {
>>     case QTYPE_QSTRING:
>>         visit_type_str(v, name, &(*obj)->u.local, &err);
> [2]
>>         break;
>>     case QTYPE_QDICT:
>>         visit_start_struct(v, name, NULL, 0, &err);
>>         if (err) {
>>             break;
> [3]
>>         }
>>         visit_type_BlockDirtyBitmap_members(v, &(*obj)->u.external, &err=
);
>>         if (!err) {
>>             visit_check_struct(v, &err);
> [4]
>>         }
>>         visit_end_struct(v, NULL);
>>         break;
>>     case QTYPE_NONE:
>>         abort();
>>     default:
>>         error_setg(&err, QERR_INVALID_PARAMETER_TYPE, name ? name : "nul=
l",
>>                    "BlockDirtyBitmapMergeSource");
> [5]
>>     }
>> out_obj:
>>     visit_end_alternate(v, (void **)obj);
>>     if (err && visit_is_input(v)) {
>>         qapi_free_BlockDirtyBitmapMergeSource(*obj);
>
> If we got here, we must have failed at any of the points mentioned above.
>
> If [1], visit_start_alternate() failed, but *obj is NULL and both
> qapi_free_FOO(NULL) and g_free(NULL) are safe.
>
> If [2], visit_type_str() failed, so *obj is allocated but the embedded
> string (here, u.local) was left NULL.  qapi_free_FOO() then does
> nothing further than g_free(obj).
>
> If [3], visit_start_struct() failed, the embedded dict (here,
> u.external) was left NULL.  qapi_free_FOO() then does nothing further
> than g_free(obj).
>
> If [5], we have the wrong ->type.  As pointed out by this commit,
> qapi_free_FOO() does nothing further than g_free(obj).
>
> But what happens in [4]?  Here, the embedded dict was allocated, but
> we then failed while parsing its members.  That leaves us in a
> partially-allocated state, and g_free(NULL) does NOT recursively visit
> that partial allocation.  I think this patch is prone to a memory leak
> unless you _also_ patch things to free any dict branch on failure
> (perhaps during the QTYPE_QDICT case label, rather than here at the
> end).

You're right.

Let's change cleanup only for the default case, like this:

       default:
           error_setg(&err, QERR_INVALID_PARAMETER_TYPE, name ? name : "nul=
l",
                      "BlockDirtyBitmapMergeSource");
 +         g_free(*obj);
 +         *obj =3D NULL;
       }
   out_obj:
       visit_end_alternate(v, (void **)obj);
       if (err && visit_is_input(v)) {
           qapi_free_BlockDirtyBitmapMergeSource(*obj);
           *obj =3D NULL;
       }
   out:
       error_propagate(errp, err);
   }

Thanks!


