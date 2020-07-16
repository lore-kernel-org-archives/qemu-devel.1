Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D0AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE6F207F9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5u2ImcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE6F207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzsM-00055j-75
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvzrl-0004Zy-Ov
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:07:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvzrj-000490-Ok
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594890462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3+UYsYs4Llt7qWDPeGiUtKuYGUBqVMn/g9L2btzCu4=;
 b=f5u2ImcQkTZAprXpXAgcXO/XY1Ypmsn4RiqxuCe4eb+CU9jnHZoFvZItLk9hQCerS/eYRA
 8CvnkscRoUggdBh5IrfjoVnGXKUC2ysAKQjFkfIlwh9NU7izVHrYuhodbMWcN7Z0kmZMY5
 V4wv3uo0xHGjtwxOEWh2BSzUjTPU0B8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-GdkLYtpZNDWgXDTZSj3m_A-1; Thu, 16 Jul 2020 05:07:41 -0400
X-MC-Unique: GdkLYtpZNDWgXDTZSj3m_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742981800D42
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:07:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F9D85D9DC;
 Thu, 16 Jul 2020 09:07:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF65911385E0; Thu, 16 Jul 2020 11:07:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH-for-5.2 4/5] qom: Let ObjectPropertyGet functions
 return a boolean value
References: <20200715175835.27744-1-philmd@redhat.com>
 <20200715175835.27744-5-philmd@redhat.com>
Date: Thu, 16 Jul 2020 11:07:38 +0200
In-Reply-To: <20200715175835.27744-5-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 15 Jul 2020 19:58:34
 +0200")
Message-ID: <87ft9rrfol.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Commits 1c94a35164..7b3cb8037c simplified the error propagation.

The complete series is b6d7e9b66f..a43770df5d.  The part you quoted
omits half of the transformation for qemu-option and QAPI.  The other
half is in

    a5f9b9df25 error: Reduce unnecessary error propagation
    992861fb1e error: Eliminate error_propagate() manually
    af175e85f9 error: Eliminate error_propagate() with Coccinelle, part 2
    668f62ec62 error: Eliminate error_propagate() with Coccinelle, part 1
    dcfe480544 error: Avoid unnecessary error_propagate() after error_setg(=
)

I'd simply point to the complete series.

> Similarly to commit 73ac1aac39 ("qdev: Make functions taking
> Error ** return bool, not void")

I think commit 6fd5bef10b "qom: Make functions taking Error ** return
bool, not void" would be a closer match.

>                                  let the ObjectPropertyGet
> functions return a boolean value, not void.

The conversion simplifies most calls at the cost of slightly
complicating the callee.  The complete series quoted above shows it can
be a good trade:

 276 files changed, 2424 insertions(+), 3567 deletions(-)

> See commit e3fe3988d7 ("error: Document Error API usage rules")
> for rationale.
>
> Cc: armbru@redhat.com
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Sorry I don't see how to split that patch without using
> ugly casts in the middle.
> ---
[...]
>  57 files changed, 325 insertions(+), 281 deletions(-)

This one's different: it converts a callback.  Many more functions than
calls.

It still improves consistency.

It should also help reduce Coverity CHECKED_RETURN false positives in
getters; see below.

>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e9496ba970..7ba2172932 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -333,9 +333,11 @@ typedef void (ObjectPropertySet)(Object *obj,
>   * @opaque: the object property opaque
>   * @errp: a pointer to an Error that is filled if getting fails.
>   *
> + * Return true on success, false on failure.
> + *
>   * Called when trying to get a property.
>   */
> -typedef void (ObjectPropertyGet)(Object *obj,
> +typedef bool (ObjectPropertyGet)(Object *obj,
>                                   Visitor *v,
>                                   const char *name,
>                                   void *opaque,
[...]
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index 08aede88dc..d59eadd4da 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -238,7 +238,7 @@ int ppc_compat_max_vthreads(PowerPCCPU *cpu)
>      return n_threads;
>  }
> =20
> -static void ppc_compat_prop_get(Object *obj, Visitor *v, const char *nam=
e,
> +static bool ppc_compat_prop_get(Object *obj, Visitor *v, const char *nam=
e,
>                                  void *opaque, Error **errp)
>  {
>      uint32_t compat_pvr =3D *((uint32_t *)opaque);
> @@ -254,7 +254,7 @@ static void ppc_compat_prop_get(Object *obj, Visitor =
*v, const char *name,
>          value =3D compat->name;
>      }
> =20
> -    visit_type_str(v, name, (char **)&value, errp);
> +    return visit_type_str(v, name, (char **)&value, errp);

Before the patch, Coverity reports

   CID 1430435:  Error handling issues  (CHECKED_RETURN)
   Calling "visit_type_str" without checking return value (as is done elsew=
here 531 out of 561 times).

False positive; not checking is fine here.  Still, avoiding false
positives is nice, as long as it can be done without impairing
readability.

>  }
> =20
>  static void ppc_compat_prop_set(Object *obj, Visitor *v, const char *nam=
e,
[...]


