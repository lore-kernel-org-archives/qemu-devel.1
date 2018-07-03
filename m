Received: from eggs.gnu.org ([2001:4830:134:3::10]:34777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNNT-0002sb-VC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNNQ-0005dk-OY
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:38:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faNNQ-0005dV-JY
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:38:00 -0400
References: <20180703085358.13941-1-armbru@redhat.com>
	<20180703085358.13941-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b014980a-14a2-3d5b-9238-1c9e2302eb35@redhat.com>
Date: Tue, 3 Jul 2018 10:37:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180703085358.13941-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/32] qmp: Get rid of x-oob-test command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

On 07/03/2018 03:53 AM, Markus Armbruster wrote:
> tests/qmp-test tests an out-of-band command overtaking a slow in-band
> command.  To do that, it needs:
> 

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

R-b stands, although:

> ---

> +static void setup_blocking_cmd(void)
> +{
> +    int rc;
> +
> +    if (!mkdtemp(tmpdir)) {
> +        g_error("mkdtemp: %s", strerror(errno));
> +    }
> +    fifo_name = g_strdup_printf("%s/fifo", tmpdir);
> +    rc = mkfifo(fifo_name, 0666);
> +    g_assert(!rc);

It's weird seeing two error handling styles in close proximity; we could 
have done:

if (!mkdtemp(tmpdir)) {
     g_error(...)
}
fifo_name = ...
if (mkfifo(fifo_name, 0666)) {
     g_error(...)
}


> +
> +static void send_oob_cmd_that_fails(QTestState *s, const char *id)

Nice change of name compared to v1.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
