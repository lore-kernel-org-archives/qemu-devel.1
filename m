Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582A2C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F1B20872
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFoJJdC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F1B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6Ng-00069L-Ic
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQ6M7-0004y8-Qp
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQ6M2-0004Sp-Je
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602065245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzTyhEwSfr6WCtBg41orXhqc6eVbnoV+QBG4W4aqFW0=;
 b=eFoJJdC2Nkl78CkNJp6AdMhRldu5TrRm6hNNMYtOrw4H4HPvol4xfVqJ6TaDm0iqvjlKnw
 UajhsVb7FIQU+Xt0LRDB4M7JnF/E5b+PpsC7dlJ6Btox12VBed3LEf4V1dq8y/uiNaqPG9
 tfEJc6MtiSnfbUy+3CcwYFzjQqOm4ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-HcfG7RJnN8uaq9AHmXQUwg-1; Wed, 07 Oct 2020 06:07:22 -0400
X-MC-Unique: HcfG7RJnN8uaq9AHmXQUwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF5357052;
 Wed,  7 Oct 2020 10:07:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-169.ams2.redhat.com [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09D0376646;
 Wed,  7 Oct 2020 10:07:06 +0000 (UTC)
Date: Wed, 7 Oct 2020 12:07:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 08/20] python/machine.py: fix _popen access
Message-ID: <20201007100705.GD7212@linux.fritz.box>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-9-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006235817.3280413-9-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.10.2020 um 01:58 hat John Snow geschrieben:
> As always, Optional[T] causes problems with unchecked access. Add a
> helper that asserts the pipe is present before we attempt to talk with
> it.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

First a question about the preexisting state: I see that after
initialising self._popen once, we never reset it to None. Should we do
so on shutdown?

>  python/qemu/machine.py | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 3e9cf09fd2d..4e762fcd529 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -131,7 +131,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
>          # Runstate
>          self._qemu_log_path = None
>          self._qemu_log_file = None
> -        self._popen = None
> +        self._popen: Optional['subprocess.Popen[bytes]'] = None

Another option that we have, especially if it's an attribute that is
never reset, would be to set the attribute only when it first gets a
value other than None. Accessing it while it hasn't been set yet
automatically results in an AttributeError. I don't think that's much
worse than the exception raised explicitly in a property wrapper.

In this case, you would only declare the type in __init__, but not
assign a value to it:

    self._popen: Optional['subprocess.Popen[bytes]']

Maybe a nicer alternative in some cases than adding properties around
everything.

Instead of checking for None, you would then have to use hasattr(),
which is a bit uglier, so I guess it's mainly for attributes where you
can assume that you will always have a value (if the caller isn't buggy)
and therefore don't even have a check in most places.

>          self._events = []
>          self._iolog = None
>          self._qmp_set = True   # Enable QMP monitor by default.
> @@ -244,6 +244,12 @@ def is_running(self):
>          """Returns true if the VM is running."""
>          return self._popen is not None and self._popen.poll() is None
>  
> +    @property
> +    def _subp(self) -> 'subprocess.Popen[bytes]':
> +        if self._popen is None:
> +            raise QEMUMachineError('Subprocess pipe not present')
> +        return self._popen
> +
>      def exitcode(self):
>          """Returns the exit code if possible, or None."""
>          if self._popen is None:

Of course, even if an alternative is possible, what you have is still
correct.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


