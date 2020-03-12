Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7F4C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4937C20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHBLKprS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4937C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOQz-0007Ms-EV
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jCOQ7-0006vA-4g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jCOQ4-0002s5-Fs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:02:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24927
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jCOQ3-0002qi-GF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584021758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cU+Zh/oWwx93lADucMMdtEB+xJOL0pIGaBbgLXt8hDY=;
 b=UHBLKprSku8B6J4TebpSXZDGgKuRHXtahEJnee93EXCiNjT7ho+4k+a8AUkN/P7ZKm0wIz
 vvOJc+JvuMDhWacDlk7SP59cpNCXlELQndCVt0BTjw3Db7xFTfmmGmX/6FvddG5BiRGxJF
 BqPGFdKIQayqytiwXH41F0gojGr4+9k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-to0RCC8ONXu4aPmbPBcw9w-1; Thu, 12 Mar 2020 10:02:21 -0400
X-MC-Unique: to0RCC8ONXu4aPmbPBcw9w-1
Received: by mail-wm1-f70.google.com with SMTP id 20so1908369wmk.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v41CflhTGy+f7D9gheFYg1AjkYWHwkf0XkBTWaBBiIw=;
 b=caCdnOhaXCj1nZA0KMyd3f3Wt0+QBUT6UwJ+sGhIO3L+3nOH973d+5cvV7b+UKZk6j
 DotRQR1+JiwSJTKtqX6Jzo+UwNI5bMLPgl4Kyw/bOfw+UsT+JDtANE0KaBOg7ElB7L3w
 8JfVWwPmBCBjYq4DjJvrpKFMbjsCaeFXGI8Ir/F5CXoMkPIWSMolwayGTp1saL9zWUsS
 VHtHqFV4fJWHqstY7nXX+a17KfjFIz7FdpVbjh6d6QlDUh8HmeUp1Fp0ITRtIuelAnRv
 Lk5QPSs13BO8oVQ0Km2LBN0hvQv+Pndmvs5dX6TMBELbvE917Jzwxks76xfVBjg1dmot
 Dhew==
X-Gm-Message-State: ANhLgQ0lNAuZZ+PadNny8lRSOjVGuKkcZ+5CprS3pIYYfUWjL6cUB4nk
 wrFzLK/RGH/NOM+hmB3CUsbr3/EDAid+Ozzgeh59zL9uqo3vwPiecr6SlkSFHLJdHq/LcJKg29M
 BHnl7MH9NKQZl76sMPyWSBIMg3pP0Yhs=
X-Received: by 2002:a1c:5401:: with SMTP id i1mr4982686wmb.177.1584021740259; 
 Thu, 12 Mar 2020 07:02:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtdK97IYGGfpJ2I7XL+f/a22NGADpcCG4Ic62Be9NSa4T4FqJDkdKYp1dqWe+TEv6EHqmdmaXVxnFMnDkJjOC8=
X-Received: by 2002:a1c:5401:: with SMTP id i1mr4982650wmb.177.1584021739783; 
 Thu, 12 Mar 2020 07:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200304100534.13155-1-ovoshcha@redhat.com>
 <63cc0e94-8fdc-cb45-e147-edeedc1a5fef@redhat.com>
In-Reply-To: <63cc0e94-8fdc-cb45-e147-edeedc1a5fef@redhat.com>
From: Oksana Voshchana <ovoshcha@redhat.com>
Date: Thu, 12 Mar 2020 16:02:08 +0200
Message-ID: <CAMXCgj55kPqSQKe2BJUXM9cSqcbs00PaBNfkkZLWnTksrPzz6g@mail.gmail.com>
Subject: Re: [PATCH] python/qemu/qmp.py: QMP debug with VM label
To: John Snow <jsnow@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000001ddfec05a0a8cdb6"
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001ddfec05a0a8cdb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John
Your approach to using logger hierarchy it's actually what I need.
Thanks for the review.
The second version of the patch I will send in a few mins

On Tue, Mar 10, 2020 at 3:46 AM John Snow <jsnow@redhat.com> wrote:

>
>
> On 3/4/20 5:05 AM, Oksana Vohchana wrote:
> > QEMUMachine writes some messages to the default logger.
> > But it sometimes to hard the read the output if we have requested to
> > more than one VM.
> > This patch adds name in QMP command if it needs and labels with it in
> > debug mode.
> >
>
> Hiya!
>
> I like the end result, but I don't like the methodology of pushing
> higher-level details into a lower-level library.
>
> > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> > ---
> >  python/qemu/machine.py | 8 ++++----
> >  python/qemu/qmp.py     | 9 ++++++---
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> > index 183d8f3d38..060e68f06b 100644
> > --- a/python/qemu/machine.py
> > +++ b/python/qemu/machine.py
> > @@ -391,7 +391,7 @@ class QEMUMachine(object):
> >              self._qmp_set =3D False
> >              self._qmp =3D None
> >
> > -    def qmp(self, cmd, conv_keys=3DTrue, **args):
> > +    def qmp(self, cmd, conv_keys=3DTrue, vm_name=3DNone, **args):
>
> in machine.py, we should already have access to self._name -- the name
> of the machine. Let's use that.
>
> >          """
> >          Invoke a QMP command and return the response dict
> >          """
> > @@ -402,15 +402,15 @@ class QEMUMachine(object):
> >              else:
> >                  qmp_args[key] =3D value
> >
> > -        return self._qmp.cmd(cmd, args=3Dqmp_args)
> > +        return self._qmp.cmd(cmd, args=3Dqmp_args, vm_name=3Dvm_name)
> >
>
> Adding a name per-each call to QMP is a bit much. Let's consolidate it
> and set it *exactly once*.
>
> A fine place to do that would be QMP's __init__ method:
>
> (in machine.py:)
>
> self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, server=3DTrue,
> remote_name=3Dself._name)
>
>
> Then, in QMP's init, you can do something like:
>
> def __init__(self, address, server=3DFalse, nickname=3DNone):
>     self.nickname =3D nickname
>
> ... and then on subsequent logging calls, you can use the nickname of
> the connection to print better logging messages.
>
>
> Some other notes:
>
> 1. QEMUMonitorProtocol uses a class variable `logger` instead of an
> instance variable logger. If this was made per-instance, you could
> change the logger of any given QMP object as-desired from the caller.
>
> 2. I'd rename the default QMP logger to be 'qemu.QMP' instead of 'QMP'
> to respect the hierarchical logging namespace.
>
> 3. If a caller set qmp.logger =3D logging.getLogger('qemu.QMP.mynamehere'=
)
> then all messages printed by this QMP instance would use the
> `mynamehere` prefix by default for all messages it printed. This might
> be enough to get the behavior you want.
>
> (Also, it would be very powerful for many other reasons, well beyond
> what you're asking for here, to allow callers to change how QMP logs,
> where, and with what messages.)
>
>
> There's probably a lot of ways to do it; but I'd pick one where we don't
> have to pass names around for every call.
>
> --js
>
>
> > -    def command(self, cmd, conv_keys=3DTrue, **args):
> > +    def command(self, cmd, conv_keys=3DTrue, vm_name=3DNone, **args):
> >          """
> >          Invoke a QMP command.
> >          On success return the response dict.
> >          On failure raise an exception.
> >          """
> > -        reply =3D self.qmp(cmd, conv_keys, **args)
> > +        reply =3D self.qmp(cmd, conv_keys, vm_name, **args)
> >          if reply is None:
> >              raise qmp.QMPError("Monitor is closed")
> >          if "error" in reply:
> > diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> > index f40586eedd..96b455b53f 100644
> > --- a/python/qemu/qmp.py
> > +++ b/python/qemu/qmp.py
> > @@ -180,11 +180,12 @@ class QEMUMonitorProtocol:
> >          self.__sockfile =3D self.__sock.makefile()
> >          return self.__negotiate_capabilities()
> >
> > -    def cmd_obj(self, qmp_cmd):
> > +    def cmd_obj(self, qmp_cmd, vm_name=3DNone):
> >          """
> >          Send a QMP command to the QMP Monitor.
> >
> >          @param qmp_cmd: QMP command to be sent as a Python dict
> > +        @param vm_name: name for the virtual machine (string)
> >          @return QMP response as a Python dict or None if the connectio=
n
> has
> >                  been closed
> >          """
> > @@ -196,10 +197,12 @@ class QEMUMonitorProtocol:
> >                  return None
> >              raise err
> >          resp =3D self.__json_read()
> > +        if vm_name:
> > +            self.logger.debug("<<< {'vm_name' : %s }",  vm_name)
> >          self.logger.debug("<<< %s", resp)
> >          return resp
> >
> > -    def cmd(self, name, args=3DNone, cmd_id=3DNone):
> > +    def cmd(self, name, args=3DNone, cmd_id=3DNone, vm_name=3DNone):
> >          """
> >          Build a QMP command and send it to the QMP Monitor.
> >
> > @@ -212,7 +215,7 @@ class QEMUMonitorProtocol:
> >              qmp_cmd['arguments'] =3D args
> >          if cmd_id:
> >              qmp_cmd['id'] =3D cmd_id
> > -        return self.cmd_obj(qmp_cmd)
> > +        return self.cmd_obj(qmp_cmd, vm_name)
> >
> >      def command(self, cmd, **kwds):
> >          """
> >
>
>

--0000000000001ddfec05a0a8cdb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0John<div>Your approach to using logger hierarchy i=
t&#39;s actually what I need.<br></div><div>Thanks for the review.<br>The s=
econd version of the patch I will send in a few mins<br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 1=
0, 2020 at 3:46 AM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
<br>
On 3/4/20 5:05 AM, Oksana Vohchana wrote:<br>
&gt; QEMUMachine writes some messages to the default logger.<br>
&gt; But it sometimes to hard the read the output if we have requested to<b=
r>
&gt; more than one VM.<br>
&gt; This patch adds name in QMP command if it needs and labels with it in<=
br>
&gt; debug mode.<br>
&gt; <br>
<br>
Hiya!<br>
<br>
I like the end result, but I don&#39;t like the methodology of pushing<br>
higher-level details into a lower-level library.<br>
<br>
&gt; Signed-off-by: Oksana Vohchana &lt;<a href=3D"mailto:ovoshcha@redhat.c=
om" target=3D"_blank">ovoshcha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 python/qemu/machine.py | 8 ++++----<br>
&gt;=C2=A0 python/qemu/qmp.py=C2=A0 =C2=A0 =C2=A0| 9 ++++++---<br>
&gt;=C2=A0 2 files changed, 10 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/python/qemu/machine.py b/python/qemu/machine.py<br>
&gt; index 183d8f3d38..060e68f06b 100644<br>
&gt; --- a/python/qemu/machine.py<br>
&gt; +++ b/python/qemu/machine.py<br>
&gt; @@ -391,7 +391,7 @@ class QEMUMachine(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._qmp_set =3D Fals=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._qmp =3D None<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def qmp(self, cmd, conv_keys=3DTrue, **args):<br>
&gt; +=C2=A0 =C2=A0 def qmp(self, cmd, conv_keys=3DTrue, vm_name=3DNone, **=
args):<br>
<br>
in machine.py, we should already have access to self._name -- the name<br>
of the machine. Let&#39;s use that.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Invoke a QMP command and return the =
response dict<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; @@ -402,15 +402,15 @@ class QEMUMachine(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_args=
[key] =3D value<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._qmp.cmd(cmd, args=3Dqmp_args=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._qmp.cmd(cmd, args=3Dqmp_args=
, vm_name=3Dvm_name)<br>
&gt;=C2=A0 <br>
<br>
Adding a name per-each call to QMP is a bit much. Let&#39;s consolidate it<=
br>
and set it *exactly once*.<br>
<br>
A fine place to do that would be QMP&#39;s __init__ method:<br>
<br>
(in machine.py:)<br>
<br>
self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, server=3DTrue,<br>
remote_name=3Dself._name)<br>
<br>
<br>
Then, in QMP&#39;s init, you can do something like:<br>
<br>
def __init__(self, address, server=3DFalse, nickname=3DNone):<br>
=C2=A0 =C2=A0 self.nickname =3D nickname<br>
<br>
... and then on subsequent logging calls, you can use the nickname of<br>
the connection to print better logging messages.<br>
<br>
<br>
Some other notes:<br>
<br>
1. QEMUMonitorProtocol uses a class variable `logger` instead of an<br>
instance variable logger. If this was made per-instance, you could<br>
change the logger of any given QMP object as-desired from the caller.<br>
<br>
2. I&#39;d rename the default QMP logger to be &#39;qemu.QMP&#39; instead o=
f &#39;QMP&#39;<br>
to respect the hierarchical logging namespace.<br>
<br>
3. If a caller set qmp.logger =3D logging.getLogger(&#39;qemu.QMP.mynameher=
e&#39;)<br>
then all messages printed by this QMP instance would use the<br>
`mynamehere` prefix by default for all messages it printed. This might<br>
be enough to get the behavior you want.<br>
<br>
(Also, it would be very powerful for many other reasons, well beyond<br>
what you&#39;re asking for here, to allow callers to change how QMP logs,<b=
r>
where, and with what messages.)<br>
<br>
<br>
There&#39;s probably a lot of ways to do it; but I&#39;d pick one where we =
don&#39;t<br>
have to pass names around for every call.<br>
<br>
--js<br>
<br>
<br>
&gt; -=C2=A0 =C2=A0 def command(self, cmd, conv_keys=3DTrue, **args):<br>
&gt; +=C2=A0 =C2=A0 def command(self, cmd, conv_keys=3DTrue, vm_name=3DNone=
, **args):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Invoke a QMP command.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On success return the response dict.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On failure raise an exception.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 reply =3D self.qmp(cmd, conv_keys, **args=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reply =3D self.qmp(cmd, conv_keys, vm_nam=
e, **args)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if reply is None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise qmp.QMPError(&qu=
ot;Monitor is closed&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;error&quot; in reply:<br>
&gt; diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py<br>
&gt; index f40586eedd..96b455b53f 100644<br>
&gt; --- a/python/qemu/qmp.py<br>
&gt; +++ b/python/qemu/qmp.py<br>
&gt; @@ -180,11 +180,12 @@ class QEMUMonitorProtocol:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__sockfile =3D self.__sock.make=
file()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.__negotiate_capabilities=
()<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def cmd_obj(self, qmp_cmd):<br>
&gt; +=C2=A0 =C2=A0 def cmd_obj(self, qmp_cmd, vm_name=3DNone):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send a QMP command to the QMP Monito=
r.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @param qmp_cmd: QMP command to be se=
nt as a Python dict<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 @param vm_name: name for the virtual mach=
ine (string)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @return QMP response as a Python dic=
t or None if the connection has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 been clo=
sed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; @@ -196,10 +197,12 @@ class QEMUMonitorProtocol:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return N=
one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise err<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resp =3D self.__json_read()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if vm_name:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger.debug(&quot;&lt=
;&lt;&lt; {&#39;vm_name&#39; : %s }&quot;,=C2=A0 vm_name)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger.debug(&quot;&lt;&lt;&lt;=
 %s&quot;, resp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return resp<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def cmd(self, name, args=3DNone, cmd_id=3DNone):<br>
&gt; +=C2=A0 =C2=A0 def cmd(self, name, args=3DNone, cmd_id=3DNone, vm_name=
=3DNone):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Build a QMP command and send it to t=
he QMP Monitor.<br>
&gt;=C2=A0 <br>
&gt; @@ -212,7 +215,7 @@ class QEMUMonitorProtocol:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_cmd[&#39;arguments=
&#39;] =3D args<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if cmd_id:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_cmd[&#39;id&#39;] =
=3D cmd_id<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.cmd_obj(qmp_cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.cmd_obj(qmp_cmd, vm_name)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def command(self, cmd, **kwds):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000001ddfec05a0a8cdb6--


