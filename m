Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A241C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143A1206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fG8dEkqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143A1206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJdC-00080K-CR
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnJcJ-00073t-E7
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:23:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnJcG-0002JH-Q9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592821431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN7N7NU/KJXTHsq4zOw7nWw/vHOCrRmLaL5p9CvbjA4=;
 b=fG8dEkqWI3KELDYs2aww6SWEIpmGIztUZKaz8ZUmYPjabKHTll8PI3SaTVc5Q/LofVDX67
 giHndnUIMtqlxN+rQCK5K/65fR02xkNXvgObU6x9R4nT6fGTSXBbzznJfHVpz5bpLr+Ol1
 WizVN76NkPEZ+7ayU6O4g3u6nQrOTvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-WQjcwv-gMxqXAF5T7d997A-1; Mon, 22 Jun 2020 06:23:49 -0400
X-MC-Unique: WQjcwv-gMxqXAF5T7d997A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A14EA805738;
 Mon, 22 Jun 2020 10:23:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D93510002A5;
 Mon, 22 Jun 2020 10:23:43 +0000 (UTC)
Date: Mon, 22 Jun 2020 12:23:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 12/16] python/machine.py: Add _qmp access shim
Message-ID: <20200622102342.GB5707@linux.fritz.box>
References: <20200604202236.25039-1-jsnow@redhat.com>
 <20200604202236.25039-13-jsnow@redhat.com>
 <659c7e95-54c3-dc20-02e3-86ce4ca74a5f@redhat.com>
 <CAP+75-UDM0zxzBWze2NvuJPQ3ezZDn3r-SsrM2q_7JU3ANiYaA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+75-UDM0zxzBWze2NvuJPQ3ezZDn3r-SsrM2q_7JU3ANiYaA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.06.2020 um 10:20 hat Philippe Mathieu-Daudé geschrieben:
> On Sat, Jun 20, 2020 at 10:14 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
> >
> > On 6/4/20 10:22 PM, John Snow wrote:
> > > Like many other Optional[] types, it's not always a given that this
> > > object will be set. Wrap it in a type-shim that raises a meaningful
> > > error and will always return a concrete type.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  python/qemu/machine.py | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> > > index d8289936816..a451f9000d6 100644
> > > --- a/python/qemu/machine.py
> > > +++ b/python/qemu/machine.py
> > > @@ -118,7 +118,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
> > >          self._events = []
> > >          self._iolog = None
> > >          self._qmp_set = True   # Enable QMP monitor by default.
> > > -        self._qmp = None
> > > +        self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] = None
> > >          self._qemu_full_args = None
> > >          self._temp_dir = None
> > >          self._launched = False
> > > @@ -285,7 +285,7 @@ def _pre_launch(self):
> > >              if self._remove_monitor_sockfile:
> > >                  assert isinstance(self._monitor_address, str)
> > >                  self._remove_files.append(self._monitor_address)
> > > -            self._qmp = qmp.QEMUMonitorProtocol(
> > > +            self._qmp_connection = qmp.QEMUMonitorProtocol(
> > >                  self._monitor_address,
> > >                  server=True,
> > >                  nickname=self._name
> > > @@ -455,7 +455,13 @@ def set_qmp_monitor(self, enabled=True):
> > >              self._qmp_set = True
> > >          else:
> > >              self._qmp_set = False
> > > -            self._qmp = None
> > > +            self._qmp_connection = None
> > > +
> > > +    @property
> > > +    def _qmp(self) -> qmp.QEMUMonitorProtocol:
> > > +        if self._qmp_connection is None:
> > > +            raise QEMUMachineError("Attempt to access QMP with no connection")
> > > +        return self._qmp_connection
> > >
> > >      @classmethod
> > >      def _qmp_args(cls, _conv_keys: bool = True, **args: Any) -> Dict[str, Any]:
> > >
> >
> > This patch breaks the EmptyCPUModel test:
> >
> > (043/101) tests/acceptance/empty_cpu_model.py:EmptyCPUModel.test:
> > ERROR: Attempt to access QMP with no connection (0.03 s)
> 
> Fixed with:
> 
> -- >8 --
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index ba6397dd7e..26ae7be89b 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -480,7 +480,7 @@ def set_qmp_monitor(self, enabled: bool = True) -> None:
> 
>      @property
>      def _qmp(self) -> qmp.QEMUMonitorProtocol:
> -        if self._qmp_connection is None:
> +        if self._qmp_set and self._qmp_connection is None:
>              raise QEMUMachineError("Attempt to access QMP with no connection")
>          return self._qmp_connection
> 
> ---
> 
> Does that sound reasonable to you?

Wouldn't that make the return type Optional[qmp.QEMUMonitorProtocol]?
Maybe this is what we want, but then we don't need the shim that this
patch adds but can just declare the variable this way.

And why does the feeling code even try to acess _qmp when _qmp_set is
False? Shouldn't it first check whether it's even valid?

Or maybe going a step back, why do we even have a separate _qmp_set
instead of only using None for _qmp?

Kevin


