Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C861C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 08:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08494223C8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7zCZ0Ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08494223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmYkS-00036B-9c
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 04:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmYjo-0002UW-Ms
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 04:20:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmYjm-0006bm-CA
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 04:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592641229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obUo6HZAdjXutnbLIE2JysT3bYunkZVGEWv7bf2UCl0=;
 b=P7zCZ0EkZoD0HW+y3vZ+8OCxYGSI2mNPYh/4qwAqf5scEiHUnlp3eZsEQV8OEnUmPEgEjs
 hZ5axsjrlarVHpyM558zFf50m6Wye4V49//Xyng/nCN/X7MQNe8lB3D9bAvyzQXNfOZF3a
 v8HmhLxHUPkVRfPTL0fHE/VP5GheAWs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-SLuG9JvoNEqyFuxqmgK1jA-1; Sat, 20 Jun 2020 04:20:27 -0400
X-MC-Unique: SLuG9JvoNEqyFuxqmgK1jA-1
Received: by mail-oo1-f69.google.com with SMTP id r5so5828374ooq.18
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 01:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=obUo6HZAdjXutnbLIE2JysT3bYunkZVGEWv7bf2UCl0=;
 b=jNYE+u1k2JctFVux74sO15mCnreTw2VCal9fYrgGluXM2CmlHcnlloN0NblfB0KzJf
 mGEbeI+V0eMHF3MYIxWg19yM1SQcoCYJPgoPsJxcGiaDW6/AfQMCpZ0/af0f1MSm83gK
 Rb8Mh7nt+T0vXuYK3HjzbMt7fBm1QCdxpAwyOFHa25rMjqmwNXSOXZLNz3rwDLBWq5fi
 255kMLsAs+W5I9kqDdMaazwbpwTRxqrCu9I1QXzMrz9hPh8hCgLj380qC2rMGRKQAxpC
 G7SgIMc3fGdwyBvPGNhyl6Y+UXcVOPfA2qtM4jgG88s+S4R+eYN0GqCUxb7kswz1PhBw
 mH/w==
X-Gm-Message-State: AOAM530mPjr7EaCKb3XJMtuXmvFSAd5sr7sWLe8Vxlo8TasYwIduao7H
 zXbufIWH42BQzaaTGEF8SFbqYk98ZtAim1iq4r+VPsB/cFN1EcUq0rtjTH0TfJBWimOtvSXvY43
 Mz/87lXN4cnR72iS9VG9o1gNHt8Gu/gI=
X-Received: by 2002:a9d:5e4:: with SMTP id 91mr6712194otd.244.1592641226322;
 Sat, 20 Jun 2020 01:20:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvU2YOsEFylScz51ZOfP0KXmYcZue/LonDf7fw8CvBVb0BqnEyRCUjeRQaxiP+sLlanoMV2cRst8P5QKGYHJA=
X-Received: by 2002:a9d:5e4:: with SMTP id 91mr6712177otd.244.1592641225981;
 Sat, 20 Jun 2020 01:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200604202236.25039-1-jsnow@redhat.com>
 <20200604202236.25039-13-jsnow@redhat.com>
 <659c7e95-54c3-dc20-02e3-86ce4ca74a5f@redhat.com>
In-Reply-To: <659c7e95-54c3-dc20-02e3-86ce4ca74a5f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Sat, 20 Jun 2020 10:20:14 +0200
Message-ID: <CAP+75-UDM0zxzBWze2NvuJPQ3ezZDn3r-SsrM2q_7JU3ANiYaA@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] python/machine.py: Add _qmp access shim
To: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 04:14:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 20, 2020 at 10:14 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 6/4/20 10:22 PM, John Snow wrote:
> > Like many other Optional[] types, it's not always a given that this
> > object will be set. Wrap it in a type-shim that raises a meaningful
> > error and will always return a concrete type.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  python/qemu/machine.py | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> > index d8289936816..a451f9000d6 100644
> > --- a/python/qemu/machine.py
> > +++ b/python/qemu/machine.py
> > @@ -118,7 +118,7 @@ def __init__(self, binary, args=3DNone, wrapper=3DN=
one, name=3DNone,
> >          self._events =3D []
> >          self._iolog =3D None
> >          self._qmp_set =3D True   # Enable QMP monitor by default.
> > -        self._qmp =3D None
> > +        self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] =3D No=
ne
> >          self._qemu_full_args =3D None
> >          self._temp_dir =3D None
> >          self._launched =3D False
> > @@ -285,7 +285,7 @@ def _pre_launch(self):
> >              if self._remove_monitor_sockfile:
> >                  assert isinstance(self._monitor_address, str)
> >                  self._remove_files.append(self._monitor_address)
> > -            self._qmp =3D qmp.QEMUMonitorProtocol(
> > +            self._qmp_connection =3D qmp.QEMUMonitorProtocol(
> >                  self._monitor_address,
> >                  server=3DTrue,
> >                  nickname=3Dself._name
> > @@ -455,7 +455,13 @@ def set_qmp_monitor(self, enabled=3DTrue):
> >              self._qmp_set =3D True
> >          else:
> >              self._qmp_set =3D False
> > -            self._qmp =3D None
> > +            self._qmp_connection =3D None
> > +
> > +    @property
> > +    def _qmp(self) -> qmp.QEMUMonitorProtocol:
> > +        if self._qmp_connection is None:
> > +            raise QEMUMachineError("Attempt to access QMP with no conn=
ection")
> > +        return self._qmp_connection
> >
> >      @classmethod
> >      def _qmp_args(cls, _conv_keys: bool =3D True, **args: Any) -> Dict=
[str, Any]:
> >
>
> This patch breaks the EmptyCPUModel test:
>
> (043/101) tests/acceptance/empty_cpu_model.py:EmptyCPUModel.test:
> ERROR: Attempt to access QMP with no connection (0.03 s)

Fixed with:

-- >8 --
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index ba6397dd7e..26ae7be89b 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -480,7 +480,7 @@ def set_qmp_monitor(self, enabled: bool =3D True) -> No=
ne:

     @property
     def _qmp(self) -> qmp.QEMUMonitorProtocol:
-        if self._qmp_connection is None:
+        if self._qmp_set and self._qmp_connection is None:
             raise QEMUMachineError("Attempt to access QMP with no connecti=
on")
         return self._qmp_connection

---

Does that sound reasonable to you?


