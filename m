Received: from eggs.gnu.org ([209.51.188.92]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtDsE-00057l-RV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtDsD-0003Yz-JU
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:51:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtDs8-0003Dk-9H
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:51:54 -0500
Date: Mon, 11 Feb 2019 15:51:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211155106.GF27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190131202637.4062-1-jusual@mail.ru>
	<d21f68cf-31fa-db62-1d20-66f75e5a05b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d21f68cf-31fa-db62-1d20-66f75e5a05b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?B?R8O2cnR6?= <contrib@steffen-goertz.de>, Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 31, 2019 at 03:03:21PM -0600, Eric Blake wrote:
> On 1/31/19 2:26 PM, Julia Suvorova via Qemu-devel wrote:
> > The whitelist option allows to run a reduced monitor with a subset of
> > QMP commands. This allows the monitor to run in secure mode, which is
> > convenient for sending commands via the WebSocket monitor using the
> > web UI. This is planned to be done on micro:bit board.
> > 
> > The list of allowed commands should be written to a file, one per line.
> > The command line will look like this:
> >     -mon chardev_name,mode=control,whitelist=path_to_file
> > 
> > Signed-off-by: Julia Suvorova <jusual@mail.ru>
> > ---
> 
> >  
> > -void monitor_init(Chardev *chr, int flags)
> > +static void process_whitelist_file(Monitor *mon, const char *whitelist_file)
> > +{
> > +    char cmd_name[256];
> > +    FILE *fd = fopen(whitelist_file, "r");
> 
> If you use qemu_open() here (followed by fdopen if you still prefer
> fscanf over read), then you can support "/dev/fdset/NNN" to
> auto-magically support someone passing in the whitelist via an inherited
> file descriptor, rather than having to be somewhere on disk that qemu
> can directly open().
> 
> > +
> > +    if (fd == NULL) {
> > +        error_report("Could not open whitelist file: %s", strerror(errno));
> > +        exit(1);
> > +    }
> > +
> > +    mon->whitelist = g_hash_table_new_full(g_str_hash,
> > +                                           g_str_equal,
> > +                                           g_free,
> > +                                           NULL);
> > +
> > +    g_hash_table_add(mon->whitelist, g_strdup("qmp_capabilities"));
> > +    g_hash_table_add(mon->whitelist, g_strdup("query-commands"));
> > +
> > +    while (fscanf(fd, "%255s", cmd_name) == 1) {
> 
> %255s fits your cmd_name array declaration and stops consuming at either
> 255 bytes or at the first whitespace encountered, but where do you check
> for overflow from a file that passes more than 255 non-whitespace bytes
> without a newline?  Also, this is a bit sloppy in that it skips all
> leading whitespace, rather than ensuring that the user actually passed
> newline-separated command names.  Does glib provide any interfaces for
> more easily reading in an array of lines from a file?

With glib, normally you'd use:

  char *content;
  gsize len;
  GError *err = NULL;
  char **lines;

  g_file_get_contents(filename, &contnet, &len, &err)

  lines = g_str_split(content, "\n", 0);

  g_free(content);

  ...do something with lines

  g_strfreev(lines);


The GIO library provides higher level functions for I/O but we don't
use that in QEMU


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
