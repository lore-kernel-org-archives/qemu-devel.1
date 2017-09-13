Received: from eggs.gnu.org ([2001:4830:134:3::10]:34137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds6gr-000418-A3
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds6go-0002Jb-5V
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:22:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds6gn-0002J6-Ux
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:22:46 -0400
Date: Wed, 13 Sep 2017 20:22:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170913122227.GH3617@pxdev.xzpeter.org>
References: <1502788964-30517-1-git-send-email-thuth@redhat.com>
	<20170913104118.GF3617@pxdev.xzpeter.org>
	<8046ee88-1d7e-b34c-e5db-f55c67f98a7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8046ee88-1d7e-b34c-e5db-f55c67f98a7e@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11] tests: Introduce generic
 device hot-plug/hot-unplug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>

On Wed, Sep 13, 2017 at 12:56:20PM +0200, Thomas Huth wrote:

[...]

> >> +
> >> +/**
> >> + * Generic hot-plugging test via the device_add QMP command
> >> + */
> >> +void qtest_hot_plug_device(const char *driver, const char *id,
> >> +                           const char *fmt, ...)
> >> +{
> >> +    QDict *response;
> >> +    char *cmd, *opts = NULL;
> >> +    va_list va;
> >> +
> >> +    if (fmt) {
> >> +        va_start(va, fmt);
> >> +        opts = g_strdup_vprintf(fmt, va);
> >> +        va_end(va);
> >> +    }
> >> +
> >> +    cmd = g_strdup_printf("{'execute': 'device_add',"
> >> +                          " 'arguments': { 'driver': '%s', 'id': '%s'%s%s }}",
> >> +                          driver, id, opts ? ", " : "", opts ? opts : "");
> >> +    g_free(opts);
> >> +
> >> +    response = qmp(cmd);
> >> +    g_free(cmd);
> >> +    g_assert(response);
> >> +    while (qdict_haskey(response, "event")) {
> >> +        /* We can get DEVICE_DELETED events in case something went wrong */
> >> +        g_assert_cmpstr(qdict_get_str(response, "event"), !=, "DEVICE_DELETED");
> >> +        QDECREF(response);
> >> +        response = qmp("");
> >> +        g_assert(response);
> >> +    }
> > 
> > I guess we don't need this block for hot plug? :-)
> 
> I'm pretty sure I've seen this happening somewhere ... but maybe it was
> just a fall-out of the mis-behaving usb test...
> I'll replace it with a  g_assert(!qdict_haskey(response, "event"))
> instead, since we should not get any events in this case, should we?

I think we should not, at least there is no such DEVICE_NEW message
defined.  Maybe that's the thing you mentioned? (say, an old test
didn't flush the read pipe so the message from the old one leaked into
a new test)

Thanks,

-- 
Peter Xu
