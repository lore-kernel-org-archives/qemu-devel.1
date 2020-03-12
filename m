Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CDC10F29
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 16:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2793F20637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 16:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTZCJR+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2793F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDVvB-0002sT-9G
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 12:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jDVMN-0001HX-Jw
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jDVMK-00035D-UB
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:39:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32978
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jDVMK-000315-PT
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584286763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jh9rZc7OHaNxOewgs7wHgs+MZ+rq/lRZmzPa03b/ndg=;
 b=DTZCJR+/JHgoD7pbS6qwaWaPKd7F+mH5pOtoc3tFAZ8byNloLYqUkGtlzEgdL5cErM3gBH
 1loCZ2kWzwC6X2rA7pB2T2MQvErva+cKc3nOAIeMEPh7vjFE0pXabDiXVfSAVWxwp1j3dP
 AWULFZ1lhaAzDGULwnUZA2PbQp20ibk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-SxxKn-uYMm-A8-iEdAcwKA-1; Sun, 15 Mar 2020 11:39:20 -0400
X-MC-Unique: SxxKn-uYMm-A8-iEdAcwKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A76D78017CC
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:39:19 +0000 (UTC)
Received: from localhost (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A697E5C1B2;
 Sun, 15 Mar 2020 15:39:16 +0000 (UTC)
Date: Thu, 12 Mar 2020 13:30:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Oksana Vohchana <ovoshcha@redhat.com>
Subject: Re: [PATCH v2] python/qemu/qmp.py: QMP debug with VM label
Message-ID: <20200312173013.GR1187748@habkost.net>
References: <20200312140547.20448-1-ovoshcha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200312140547.20448-1-ovoshcha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 04:05:47PM +0200, Oksana Vohchana wrote:
> QEMUMachine writes some messages to the default logger.
> But it sometimes hard to read the output if we have requests to
> more than one VM.
> This patch adds a label to the logger in the debug mode.
>=20
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
>=20
> ---
> v2:
>  - Instead of shown the label in the message it provides the label
>    only in the debug logger information
> ---
>  python/qemu/machine.py | 2 +-
>  python/qemu/qmp.py     | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 183d8f3d38..d0aa774c1c 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -270,7 +270,7 @@ class QEMUMachine(object):
>                  self._vm_monitor =3D os.path.join(self._sock_dir,
>                                                  self._name + "-monitor.s=
ock")
>                  self._remove_files.append(self._vm_monitor)
> -            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, serv=
er=3DTrue)
> +            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, serv=
er=3DTrue, nickname=3Dself._name)
> =20
>      def _post_launch(self):
>          if self._qmp:
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index f40586eedd..d58b18c304 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -46,7 +46,7 @@ class QEMUMonitorProtocol:
>      #: Logger object for debugging messages
>      logger =3D logging.getLogger('QMP')

This will create a single logger instance.

> =20
> -    def __init__(self, address, server=3DFalse):
> +    def __init__(self, address, server=3DFalse, nickname=3DNone):
>          """
>          Create a QEMUMonitorProtocol class.
> =20
> @@ -62,6 +62,7 @@ class QEMUMonitorProtocol:
>          self.__address =3D address
>          self.__sock =3D self.__get_sock()
>          self.__sockfile =3D None
> +        self._nickname =3D nickname
>          if server:
>              self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADD=
R, 1)
>              self.__sock.bind(self.__address)
> @@ -188,6 +189,8 @@ class QEMUMonitorProtocol:
>          @return QMP response as a Python dict or None if the connection =
has
>                  been closed
>          """
> +        if self._nickname:
> +            self.logger.name =3D 'QMP.{}'.format(self._nickname)

This will change the name of that single instance and affect
every single QEMUMonitorProtocol object.  Please don't do that.

You can just do:

    self.logger =3D logging.getLogger('QMP').getChild(self._nickname)

at __init__().


>          self.logger.debug(">>> %s", qmp_cmd)
>          try:
>              self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
> --=20
> 2.21.1
>=20

--=20
Eduardo


