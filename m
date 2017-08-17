Received: from eggs.gnu.org ([2001:4830:134:3::10]:38360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diGPS-0003rF-W9
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diGPO-0000Eh-3g
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:44:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diGPN-0000DE-T7
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:44:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5BC8C08735A
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 08:44:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-18-marcandre.lureau@redhat.com>
	<87h8x6obqr.fsf@dusky.pond.sub.org>
Date: Thu, 17 Aug 2017 10:43:58 +0200
In-Reply-To: <87h8x6obqr.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 17 Aug 2017 10:10:52 +0200")
Message-ID: <871soamvn5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 17/26] qapi: add conditions to SPICE
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

[...]
> Check for completeness by reviewing the case insensitive occurrences of
> SPICE in the schema not covered by your patch:
>
> * add_client
>
>   Same rationale as for VNC (see my review of PATCH 16).  Good.

Hmm, there's a difference to VNC, in qmp_add_client():

    if (strcmp(protocol, "spice") == 0) {
        if (!qemu_using_spice(errp)) {
            close(fd);
            return;
        }
        skipauth = has_skipauth ? skipauth : false;
        tls = has_tls ? tls : false;
        if (qemu_spice_display_add_client(fd, skipauth, tls) < 0) {
            error_setg(errp, "spice failed to add client");
            close(fd);
        }
        return;
#ifdef CONFIG_VNC
    } else if (strcmp(protocol, "vnc") == 0) {
        skipauth = has_skipauth ? skipauth : false;
        vnc_display_add_client(NULL, fd, skipauth);
        return;
#endif
    } else if ((s = qemu_chr_find(protocol)) != NULL) {
        if (qemu_chr_add_client(s, fd) < 0) {
            error_setg(errp, "failed to add client");
            close(fd);
            return;
        }
        return;
    }

    error_setg(errp, "protocol '%s' is invalid", protocol);
    close(fd);

Observe:

* Protocol "spice" is always recognized.  Without CONFIG_SPICE,
  using_spice is always false, and the command fails with
  qemu_using_spice()'s error "SPICE is not in use".

* Protocol "vnc" is only recognized with CONFIG_VNC.  Without, it's
  rejected with "protocol 'vnc' is invalid".

* If you name your character device "spice" or "vnc", you can't use it
  with add_client.  This is a design flaw.

  Except you can use one named "vnc" when !CONFIG_VNC.

  I'm afraid the command needs to be replaced.  Not in this series, of
  course.

[...]
