Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76883C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401992086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha2/B/qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401992086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2X7w-0001uq-H3
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 04:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j2X7F-0001Tk-VY
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j2X7E-0004RO-Q5
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:18:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j2X7E-0004Qh-Ll
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581671908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Y2/tfyDRqBEW3Tsws4NB5cvfHARUzPSMn0vCCM2khk=;
 b=Ha2/B/qjwhXuVqdhkOXdjJWv36tbeZ5de795Hfm39Lgg1LtNaL9f/JW+vehTeaXLGjAOiC
 d3PPUpkSgzrF+xAO8w2bTg269EeejTHunn7/PpiB5unu5o9o3BiXdm0EoDCoNIadNl9AzN
 AmzRIPj4BgXFRSCxq2IBm5dqh+Vad3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-K2AWc3QQP_usSrpEJTIGrw-1; Fri, 14 Feb 2020 04:18:13 -0500
Received: by mail-wr1-f72.google.com with SMTP id d15so3714444wru.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 01:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pUMaPa89NKFqx5hMSH4VLrUXRFAU5w/4xlPOeovO7AI=;
 b=die80CZHOo06euTIlwgLYeSyNPRCnm9ndffWS4Gh0SlkP+6hJrRxeszwPoQvEm52ra
 EarTHNOZC4Cbuk3mdiO6plvcOH52q22WoefCjkmW9BjLpqsLIgk8Bb9Hj8ZlAQLjK0yz
 ijR7WJUxo3pyKiNpso3CNsId7lVCk2K7oOwqFlFaOynnv7OZQXbtkvzPaAWpZgQPOTiZ
 6Upk3wWjoDfeLy647B3/0+9s/SD1IyP8TAgUn9gsJW7DNgXG0YqcZG6brSi8jNAIpj6S
 AeQvKFf4/IJS70IQ0AH9D6xN7mH4HBroiWd9ZCQsLau6o4/wM/7h1Eq1WRkV/L7AatEa
 TvXg==
X-Gm-Message-State: APjAAAX0SSThqqNtkQit3lakqvu0e78lJ5A0bS4ZHzfuTjUeBpn8k+71
 v/fhNmScpBz0ssl214mfUXWMsnHNWBjhhKLKZ/h1AmyM33wcqo+es0c1FX+ECSnpFx0ZL/pZ7A1
 4rLI6CRiOU8XQkaw=
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr3709933wmi.118.1581671891924; 
 Fri, 14 Feb 2020 01:18:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLh8alPIdn5bSkuhspH0dM6+jxqv7UO8dFMnaEKFD0W6xvoz6Y3/r/TA9n1/TtpfCD5f2Yow==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr3709899wmi.118.1581671891594; 
 Fri, 14 Feb 2020 01:18:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id l8sm6752182wmj.2.2020.02.14.01.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 01:18:11 -0800 (PST)
Subject: Re: [PATCH v2 04/19] tests/rcutorture: mild documenting refactor of
 update thread
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-5-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2033617-a747-531c-66a6-a33c1b9d6aa8@redhat.com>
Date: Fri, 14 Feb 2020 10:18:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200213225109.13120-5-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: K2AWc3QQP_usSrpEJTIGrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 robhenry@microsoft.com, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/02/20 23:50, Alex Benn=C3=A9e wrote:
> This is mainly to help with reasoning what the test is trying to do.
> We can move rcu_stress_idx to a local variable as there is only ever
> one updater thread. I've also added an assert to catch the case where
> we end up updating the current structure to itself which is the only
> way I can see the mberror cases we are seeing on Travis.
>=20
> We shall see if the rcutorture test failures go away now.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Yes, the failures are quire mysterious and I agree that they can only happe=
n if:

1) p =3D=3D cp in your patch below

2) the memory barrier can be overtaken by the store above it.

Even then, (2) would be unlikely because then the compiler would=20
coalesce the two stores to p->mbtest.  However we could add a patch such=20
as this to rule it out:

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 9559f13..969a19a 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -260,7 +260,7 @@ static void *rcu_read_stress_test(void *arg)
     while (goflag =3D=3D GOFLAG_RUN) {
         rcu_read_lock();
         p =3D atomic_rcu_read(&rcu_stress_current);
-        if (p->mbtest =3D=3D 0) {
+        if (atomic_read(&p->mbtest) =3D=3D 0) {
             n_mberror++;
         }
         rcu_read_lock();
@@ -268,7 +268,7 @@ static void *rcu_read_stress_test(void *arg)
             garbage++;
         }
         rcu_read_unlock();
-        pc =3D p->pipe_count;
+        pc =3D atomic_read(&p->pipe_count);
         rcu_read_unlock();
         if ((pc > RCU_STRESS_PIPE_LEN) || (pc < 0)) {
             pc =3D RCU_STRESS_PIPE_LEN;
@@ -319,10 +319,10 @@ static void *rcu_update_stress_test(void *arg)
         p =3D &rcu_stress_array[rcu_stress_idx];
         /* catching up with ourselves would be a bug */
         assert(p !=3D cp);
-        p->mbtest =3D 0;
+        atomic_set(&p->mbtest, 0);
         smp_mb();
-        p->pipe_count =3D 0;
-        p->mbtest =3D 1;
+        atomic_set(&p->pipe_count, 0);
+        atomic_set(&p->mbtest, 1);
         atomic_rcu_set(&rcu_stress_current, p);
         cp =3D p;
         /*
@@ -331,7 +331,8 @@ static void *rcu_update_stress_test(void *arg)
          */
         for (i =3D 0; i < RCU_STRESS_PIPE_LEN; i++) {
             if (i !=3D rcu_stress_idx) {
-                rcu_stress_array[i].pipe_count++;
+                atomic_set(&rcu_stress_array[i].pipe_count,
+=09=09=09   rcu_stress_array[i].pipe_count + 1);
             }
         }
         synchronize_rcu();


Finally, the "pipe_count" naming is a bit mysterious.  The idea behind the =
test
is that RCU can only ever see the current or the previous version of a
struct (in this case, the current or the previous index) and a "pipe_count"
of 3 means for example that the index is 3 updates behind the current
index.  To check that the RCU invariant is preserved, the test checks that
the reader does not observe an index that is 2 updates or more behind the
current index.

I have never changed it because I took it directly from Paul McKenney's
rcutorture and I didn't want to deviate too much in order to keep Paul's
code as a reference.  But perhaps we should rename it to something more
intuitive like "age" (which is short enough that "pc" could also be
renamed to "age").

Paolo


