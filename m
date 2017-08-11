Received: from eggs.gnu.org ([2001:4830:134:3::10]:59296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg5um-0001Yt-4u
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg5uj-0001Ju-1E
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:07:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dg5ui-0001Jb-RZ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:07:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35D9652545
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 09:07:27 +0000 (UTC)
Date: Fri, 11 Aug 2017 10:07:15 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811090715.GB2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-2-berrange@redhat.com>
	<7c6d31b3-6d1f-f8de-c9bd-74b7e1b324f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c6d31b3-6d1f-f8de-c9bd-74b7e1b324f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/15] ui: add keycodemapdb repository as a
 GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Aug 10, 2017 at 01:23:08PM -0500, Eric Blake wrote:
> On 08/10/2017 10:55 AM, Daniel P. Berrange wrote:
> > The https://gitlab.com/keycodemap/keycodemapdb/ repo contains a
> > data file mapping between all the different scancode/keycode/keysym
> > sets that are known, and a tool to auto-generate lookup tables for
> > different combinations.
> > 
> > It is used by GTK-VNC, SPICE-GTK and libvirt for mapping keys.
> > Using it in QEMU will let us replace many hand written lookup
> > tables with auto-generated tables from a master data source,
> > reducing bugs. Adding new QKeyCodes will now only require the
> > master table to be updated, all ~20 other tables will be
> > automatically updated to follow.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> 
> > +
> > +ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) ui/Makefile.objs
> > +	$(call quiet-command,\
> > +	    $(PYTHON) $(KEYCODEMAP_GEN) \
> > +	          --lang glib2 \
> > +	          --varname qemu_input_map_$$(echo $@ | sed -e "s,^ui/input-keymap-,," -e "s,\.c$$,,") \
> > +	          code-map $(KEYCODEMAP_CSV) \
> > +	          $$(echo $@ | sed -E -e "s,^ui/input-keymap-([a-zA-Z0-9]+)2([a-zA-Z0-9]+)\.c$$,\1,") \
> > +	          $$(echo $@ | sed -E -e "s,^ui/input-keymap-([a-zA-Z0-9]+)2([a-zA-Z0-9]+)\.c$$,\2,") \
> 
> Can this text transformation be done using intrinsic make functions,
> instead of requiring the shell to spawn external processes?

Suggestions welcome :-)

> The regex looks fragile: if we ever have one keymap named '2abc' and
> another named 'xyz2', then the input-keymap-xyz222abc may be difficult
> to extract based on greedy matching favoring 'xyz22' 2 'abc'.  Would it
> be better to have 'xyz2-to-2abc' as the preferred naming in the
> keycodemapdb project, to make sure the conversion names are unambiguous?

The names may end in a digit, but they won't start in a digit, so
its unambiguous


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
