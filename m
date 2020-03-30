Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2616C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFE320578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwIy9Uvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFE320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxI6-0002lz-LV
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jIxG8-0008Tw-Pn
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jIxG7-000549-H8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:27:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jIxG7-00053B-D0
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585585651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rMpOUraWkxMhkhCUHL/Gm625UVwcDWCyeVTKmouIHY=;
 b=DwIy9Uvkd9yuxBnR4ysqMGSzGIU02ytgGzj0PGgZqyyckhrbV6Bg1YYEhZisls1fUnlvfb
 nyvVjrvYUH4aNmPG6aCjsjMQsOAh/xu55i2JqkBoZlRRLEu6xkyidkNy0iZ80LnFvW5Ikp
 LFcP7vHDKHIRGtlGneY48jTdUH977SY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-vEVIMPoSMDyJ_fPv95Bgvw-1; Mon, 30 Mar 2020 12:27:27 -0400
X-MC-Unique: vEVIMPoSMDyJ_fPv95Bgvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500FD107ACC4;
 Mon, 30 Mar 2020 16:27:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEC2096B79;
 Mon, 30 Mar 2020 16:27:24 +0000 (UTC)
Date: Mon, 30 Mar 2020 18:27:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v9 10/14] iotests: add hmp helper with logging
Message-ID: <20200330162723.GH6139@linux.fritz.box>
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-11-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200324232103.4195-11-jsnow@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 philmd@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.03.2020 um 00:20 hat John Snow geschrieben:
> Just a mild cleanup while I was here.
>=20
> Although we now have universal qmp logging on or off, many existing
> callers to hmp functions don't expect that output to be logged, which
> causes quite a few changes in the test output.
>=20
> For now, just offer a use_log parameter.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index e12d6e533e..4faee06f14 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -540,25 +540,29 @@ def add_incoming(self, addr):
>          self._args.append(addr)
>          return self
> =20
> -    def pause_drive(self, drive, event=3DNone):
> -        '''Pause drive r/w operations'''
> +    def hmp(self, command_line: str, use_log: bool =3D False):

Missing return type. Should probably be Dict[str, Any]?

> +        cmd =3D 'human-monitor-command'
> +        kwargs =3D {'command-line': command_line}
> +        if use_log:
> +            return self.qmp_log(cmd, **kwargs)
> +        else:
> +            return self.qmp(cmd, **kwargs)
> +
> +    def pause_drive(self, drive: str, event: Optional[str] =3D None) -> =
None:
> +        """Pause drive r/w operations"""
>          if not event:
>              self.pause_drive(drive, "read_aio")
>              self.pause_drive(drive, "write_aio")
>              return
> -        self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "break %s bp_%s"'
> -                 % (drive, event, drive))
> +        self.hmp(f'qemu-io {drive} "break {event} bp_{drive}"')
> =20
> -    def resume_drive(self, drive):
> -        self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "remove_break bp_%s"'
> -                 % (drive, drive))
> +    def resume_drive(self, drive: str) -> None:
> +        """Resume drive r/w operations"""
> +        self.hmp(f'qemu-io {drive} "remove_break bp_{drive}"')
> =20
> -    def hmp_qemu_io(self, drive, cmd):
> -        '''Write to a given drive using an HMP command'''
> -        return self.qmp('human-monitor-command',
> -                        command_line=3D'qemu-io %s "%s"' % (drive, cmd))
> +    def hmp_qemu_io(self, drive: str, cmd: str, use_log: bool =3D False)=
 -> None:
> +        """Write to a given drive using an HMP command"""
> +        return self.hmp(f'qemu-io {drive} "{cmd}"', use_log=3Duse_log)

Once you have a non-Any return type for hmp(), this would report that
you return something for a function declared to return None.

Kevin


