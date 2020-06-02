Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ECCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 10:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE44206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 10:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkbfEqgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE44206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg41Y-0000ee-4K
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 06:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg40h-00080R-FG
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:19:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg40f-0006DI-4e
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591093143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWFiJS2EcgIuNMxh//XBRhlKaL9xUwxU22fn2pot/cs=;
 b=WkbfEqglAX3kzw9mCOlyKkVydEGEMVaI94e76ZNxIjJAYNWTuckesCjVBW0QxZTX3JBVYl
 kl8Ij8KyEmUS0sR0n47ORYEwCUv049kGYyWGm5ExipoTSgH94nB6qmLOtedOCKdGb22QJy
 3l8dqw80kPdeJLG0poG7GK17STyTMUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-FjyOEw8WPmWCoXRuG8yfEA-1; Tue, 02 Jun 2020 06:19:00 -0400
X-MC-Unique: FjyOEw8WPmWCoXRuG8yfEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20AED108BD0F;
 Tue,  2 Jun 2020 10:18:59 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF783610F3;
 Tue,  2 Jun 2020 10:18:56 +0000 (UTC)
Date: Tue, 2 Jun 2020 12:18:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC 26/32] python//machine.py: use qmp.command
Message-ID: <20200602101855.GB5940@linux.fritz.box>
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-27-jsnow@redhat.com>
 <0baff903-779b-c583-8ba6-6a28a4a10a42@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0baff903-779b-c583-8ba6-6a28a4a10a42@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 23:49:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.05.2020 um 02:18 hat John Snow geschrieben:
> 
> [...]
> 
> >  
> > -    def qmp(self, cmd, conv_keys=True, **args):
> > -        """
> > -        Invoke a QMP command and return the response dict
> > -        """
> > +    @classmethod
> > +    def _qmp_args(cls, _conv_keys: bool = True, **args: Any) -> Dict[str, Any]:
> >          qmp_args = dict()
> >          for key, value in args.items():
> > -            if conv_keys:
> > +            if _conv_keys:
> >                  qmp_args[key.replace('_', '-')] = value
> >              else:
> >                  qmp_args[key] = value
> > +        return qmp_args
> >  
> > +    def qmp(self, cmd: str,
> > +            conv_keys: bool = True,
> > +            **args: Any) -> QMPMessage:
> 
> This creates an interesting problem with iotests 297:
> 
> 
> -Success: no issues found in 1 source file
> +iotests.py:563: error: Argument 2 to "qmp" of "QEMUMachine" has
> incompatible type "**Dict[str, str]"; expected "bool"
> +Found 1 error in 1 file (checked 1 source file)
> 
> 
> def hmp(self, command_line: str, use_log: bool = False) -> QMPResponse:
>     cmd = 'human-monitor-command'
>     kwargs = {'command-line': command_line}
>     if use_log:
>         return self.qmp_log(cmd, **kwargs)
>     else:
>         return self.qmp(cmd, **kwargs)
> 
> It seems like mypy is unable to understand that we are passing keyword
> arguments, and instead believes we're passing something to the conv_keys
> parameter.
> 
> (Is this a bug...?)

It took some experimenting, but in the end, I think the logic behind it
is reasonable enough. If you have kwargs: Dict[str, T] and pass it as
**kwargs, mypy checks that passing T to _every_ keyword argument is fine
because generally speaking you have to expect that the name of any
argument could be present in kwargs. (In the specific example, of
course, we know all the keys, but mypy doesn't look at the content of
the dict.)

With this in mind, getting rid of the error is very simple because you
only need to make sure that T is Any instead of str:

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7eb714b8e5..0258f1359a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -556,7 +556,7 @@ class VM(qtest.QEMUQtestMachine):
 
     def hmp(self, command_line: str, use_log: bool = False) -> QMPResponse:
         cmd = 'human-monitor-command'
-        kwargs = {'command-line': command_line}
+        kwargs: Dict[str, Any] = {'command-line': command_line}
         if use_log:
             return self.qmp_log(cmd, **kwargs)
         else:

Kevin


