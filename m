Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQWlL-00068W-CS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQWlI-00054G-AP
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:37:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQWlI-00053y-5r
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:37:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54370401DE62
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 11:37:55 +0000 (UTC)
Date: Wed, 6 Jun 2018 12:37:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180606113752.GA3064@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180606104357.GB3205@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606104357.GB3205@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] 100% host cpu with gtk3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Wed, Jun 06, 2018 at 06:43:57PM +0800, Fam Zheng wrote:
> Hi Gerd,
> 
> When using the gtk frontend, it seems there is a busy loop in libgtk repeatedly
> calling recvmsg, causing 100% cpu on the main thread. This started to appear
> after I upgraded to Fedora 28. Is this a known problem?
> 
> Any hints on how to track it down?

GLib has systemtap probes registered in its dispatch code. These probes
will include the name of the GSource. You could possibly use this to
identify which GSource is firing too often.

eg in gmain.c in glib code there are these events to hook into:

          TRACE (GLIB_MAIN_BEFORE_DISPATCH (g_source_get_name (source), source,
                                            dispatch, callback, user_data));
          need_destroy = !(* dispatch) (source, callback, user_data);
          TRACE (GLIB_MAIN_AFTER_DISPATCH (g_source_get_name (source), source,
                                           dispatch, need_destroy));



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
