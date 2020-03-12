Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72417C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551AC206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F34APze5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551AC206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCICE-0000mi-GF
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 03:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCIBb-0000Gs-1W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCIBZ-0006qC-IA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:23:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCIBZ-0006py-EE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583997796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/E8vVaoVhY2Wg/52ttoswbyBRSnCcZJrMygi5WSQw1w=;
 b=F34APze502zfjPSJsJxlpAByYhQYwFpu50oJl+fM0xoTpV0CWlTsIl5qx3RxzLDUosnWdZ
 nmYdNPRY4WMXR66I/ZnRHQHIgb9+hnSpd0HWmH/KRYmi30Jmogv8uoAaAqV7q5RdJRQU9u
 uEQgaA+NDJrU4AdQjvxrncLDlVQ3Et0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-_emMESS8ND6FvGKl12tXNw-1; Thu, 12 Mar 2020 03:23:15 -0400
X-MC-Unique: _emMESS8ND6FvGKl12tXNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0934801E66;
 Thu, 12 Mar 2020 07:23:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34ECE92D30;
 Thu, 12 Mar 2020 07:23:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B64EC11386A6; Thu, 12 Mar 2020 08:23:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <fda76f8a-bb62-d867-d7b4-7cf8caf0489e@virtuozzo.com>
 <87a74ngriw.fsf@dusky.pond.sub.org>
 <71ada30b-c72b-6251-cc38-877ddd4156a8@virtuozzo.com>
 <87h7yvx8ce.fsf@dusky.pond.sub.org>
 <a16e5dee-7f2b-236d-1e71-f40c75cb5902@virtuozzo.com>
Date: Thu, 12 Mar 2020 08:23:05 +0100
In-Reply-To: <a16e5dee-7f2b-236d-1e71-f40c75cb5902@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 11 Mar 2020 17:46:10 +0300")
Message-ID: <87blp2rq92.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 11.03.2020 17:41, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> 11.03.2020 12:38, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> 09.03.2020 12:56, Markus Armbruster wrote:
>>>>>> Suggest
>>>>>>
>>>>>>        scripts: Coccinelle script to use auto-propagated errp
>>>>>>
>>>>>> or
>>>>>>
>>>>>>        scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>>>>>
>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>> [...]
>>>>>>> +// Note, that we update everything related to matched by rule1 fun=
ction name
>>>>>>> +// and local_err name. We may match something not related to the p=
attern
>>>>>>> +// matched by rule1. For example, local_err may be defined with th=
e same name
>>>>>>> +// in different blocks inside one function, and in one block follo=
w the
>>>>>>> +// propagation pattern and in other block doesn't. Or we may have =
several
>>>>>>> +// functions with the same name (for different configurations).
>>>>>>
>>>>>> Context: rule1 matches functions that have all three of
>>>>>>
>>>>>> * an Error **errp parameter
>>>>>>
>>>>>> * an Error *local_err =3D NULL variable declaration
>>>>>>
>>>>>> * an error_propagate(errp, local_err) or error_propagate_prepend(err=
p,
>>>>>>      local_err, ...) expression, where @errp is the parameter and
>>>>>>      @local_err is the variable.
>>>>>>
>>>>>> If I understand you correctly, you're pointing out two potential iss=
ues:
>>>>>>
>>>>>> 1. This rule can match functions rule1 does not match if there is
>>>>>> another function with the same name that rule1 does match.
>>>>>>
>>>>>> 2. This rule matches in the entire function matched by rule1, even w=
hen
>>>>>> parts of that function use a different @errp or @local_err.
>>>>>>
>>>>>> I figure these apply to all rules with identifier rule1.fn, not just
>>>>>> this one.  Correct?
>>>>>>
>>>>>> Regarding 1.  There must be a better way to chain rules together, bu=
t I
>>>>>> don't know it.
>>>>>
>>>>> Hmm, what about something like this:
>>>>>
>>>>> @rule1 disable optional_qualifier exists@
>>>>> identifier fn, local_err;
>>>>> symbol errp;
>>>>> @@
>>>>>
>>>>>    fn(..., Error **
>>>>> - errp
>>>>> + ___errp_coccinelle_updating___
>>>>>       , ...)
>>>>>    {
>>>>>        ...
>>>>>        Error *local_err =3D NULL;
>>>>>        ...
>>>>> (
>>>>>       error_propagate_prepend(errp, local_err, ...);
>>>>> |
>>>>>       error_propagate(errp, local_err);
>>>>> )
>>>>>        ...
>>>>>    }
>>>>>
>>>>>
>>>>> [..]
>>>>>
>>>>> match symbol ___errp_coccinelle_updating___ in following rules in fun=
ction header
>>>>>
>>>>> [..]
>>>>>
>>>>>
>>>>> @ disable optional_qualifier@
>>>>> identifier fn, local_err;
>>>>> symbol errp;
>>>>> @@
>>>>>
>>>>>    fn(..., Error **
>>>>> - ___errp_coccinelle_updating___
>>>>> + errp
>>>>>       , ...)
>>>>>    {
>>>>>        ...
>>>>>    }
>>>>>
>>>>>
>>>>> - hacky, but seems not more hacky than python detection, and should w=
ork better
>>>>
>>>> As simple, forceful and unsubtle as a sledgehammer.  I like it :)
>>>>
>>>
>>>
>>> Hmm, not so simple.
>>>
>>> It leads to reindenting of function header, which is bad.
>>
>> Because ___errp_coccinelle_updating___ is longer than errp, I guess.
>> Try ____?
>
> I'm afraid not. It's because it just adds \n, when I do
>
> ...,
>
> - errp
> + ___errp_coccinelle_updating___
> ,...

I was thinking of something like the appended patch, which in my
(superficial!) testing leaves alone newlines unless lines are long, but
hangs for block.c.  Oh well.


diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coccin=
elle/auto-propagated-errp.cocci
index bff274bd6d..492a4db826 100644
--- a/scripts/coccinelle/auto-propagated-errp.cocci
+++ b/scripts/coccinelle/auto-propagated-errp.cocci
@@ -35,12 +35,12 @@
 // error_propagate_prepend().
 @ depends on !(file in "util/error.c") disable optional_qualifier@
 identifier fn;
-identifier _errp !=3D errp;
+identifier _errp;
 @@
=20
  fn(...,
 -   Error **_errp
-+   Error **errp
++   Error **____
     ,...)
  {
 (
@@ -48,7 +48,7 @@ identifier _errp !=3D errp;
 &
      <...
 -    _errp
-+    errp
++    ____
      ...>
 )
  }
@@ -63,26 +63,26 @@ identifier _errp !=3D errp;
 // all possible control flows (otherwise, it will not match standard patte=
rn
 // when error_propagate() call is in if branch).
 @ disable optional_qualifier exists@
-identifier fn, local_err, errp;
+identifier fn, local_err;
 @@
=20
- fn(..., Error **errp, ...)
+ fn(..., Error **____, ...)
  {
 +   ERRP_AUTO_PROPAGATE();
     ...  when !=3D ERRP_AUTO_PROPAGATE();
 (
-    error_append_hint(errp, ...);
+    error_append_hint(____, ...);
 |
-    error_prepend(errp, ...);
+    error_prepend(____, ...);
 |
-    error_vprepend(errp, ...);
+    error_vprepend(____, ...);
 |
     Error *local_err =3D NULL;
     ...
 (
-    error_propagate_prepend(errp, local_err, ...);
+    error_propagate_prepend(____, local_err, ...);
 |
-    error_propagate(errp, local_err);
+    error_propagate(____, local_err);
 )
 )
     ... when any
@@ -92,18 +92,17 @@ identifier fn, local_err, errp;
 // Match scenarios with propagation of local error to errp.
 @rule1 disable optional_qualifier exists@
 identifier fn, local_err;
-symbol errp;
 @@
=20
- fn(..., Error **errp, ...)
+ fn(..., Error **____, ...)
  {
      ...
      Error *local_err =3D NULL;
      ...
 (
-    error_propagate_prepend(errp, local_err, ...);
+    error_propagate_prepend(____, local_err, ...);
 |
-    error_propagate(errp, local_err);
+    error_propagate(____, local_err);
 )
      ...
  }
@@ -118,7 +117,6 @@ symbol errp;
 // without error_propagate() call), coccinelle fails to match this "out: }=
".
 @@
 identifier rule1.fn, rule1.local_err, out;
-symbol errp;
 @@
=20
  fn(...)
@@ -128,7 +126,7 @@ symbol errp;
 +    return;
      ...>
 - out:
--    error_propagate(errp, local_err);
+-    error_propagate(____, local_err);
  }
=20
 // Convert most of local_err related staff.
@@ -159,7 +157,6 @@ symbol errp;
 @ exists@
 identifier rule1.fn, rule1.local_err;
 expression list args;
-symbol errp;
 @@
=20
  fn(...)
@@ -172,30 +169,30 @@ symbol errp;
 // Convert error clearing functions
 (
 -    error_free(local_err);
-+    error_free_errp(errp);
++    error_free_errp(____);
 |
 -    error_report_err(local_err);
-+    error_report_errp(errp);
++    error_report_errp(____);
 |
 -    error_reportf_err(local_err, args);
-+    error_reportf_errp(errp, args);
++    error_reportf_errp(____, args);
 |
 -    warn_report_err(local_err);
-+    warn_report_errp(errp);
++    warn_report_errp(____);
 |
 -    warn_reportf_err(local_err, args);
-+    warn_reportf_errp(errp, args);
++    warn_reportf_errp(____, args);
 )
 ?-    local_err =3D NULL;
=20
 |
--    error_propagate_prepend(errp, local_err, args);
-+    error_prepend(errp, args);
+-    error_propagate_prepend(____, local_err, args);
++    error_prepend(____, args);
 |
--    error_propagate(errp, local_err);
+-    error_propagate(____, local_err);
 |
 -    &local_err
-+    errp
++    ____
 )
      ...>
  }
@@ -205,27 +202,43 @@ symbol errp;
 // conflicts with other substitutions in it (at least with "- local_err =
=3D NULL").
 @@
 identifier rule1.fn, rule1.local_err;
-symbol errp;
 @@
=20
  fn(...)
  {
      <...
 -    local_err
-+    *errp
++    *____
      ...>
  }
=20
 // Always use the same patter for checking error
 @@
 identifier rule1.fn;
-symbol errp;
 @@
=20
  fn(...)
  {
      <...
--    *errp !=3D NULL
-+    *errp
+-    *____ !=3D NULL
++    *____
      ...>
  }
+
+@@
+identifier fn;
+symbol errp;
+@@
+
+ fn(...,
+-   Error **____
++   Error **errp
+    ,...)
+ {
+ ...
+ }
+
+@@
+@@
+-____
++errp


