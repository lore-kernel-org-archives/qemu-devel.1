Received: from eggs.gnu.org ([209.51.188.92]:33709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyjh9-0001sK-26
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyjh8-0004HL-5U
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:51:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gyjh7-0004Gg-Qp
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:51:18 -0500
References: <HK2PR0401MB1955AC7A64864AFEEE3A2E88DE7B0@HK2PR0401MB1955.apcprd04.prod.outlook.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79df8e74-958a-c551-c0d8-e222df347fdc@redhat.com>
Date: Tue, 26 Feb 2019 14:51:13 -0600
MIME-Version: 1.0
In-Reply-To: <HK2PR0401MB1955AC7A64864AFEEE3A2E88DE7B0@HK2PR0401MB1955.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] question about qemu-monitor-event result
 redirecting to a file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhan Adlun <zhanhouliang@outlook.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 2/26/19 5:51 AM, Zhan Adlun wrote:
> Dear Sir:
>       Sorry to bother you. I use dirty bitmap to do backup in KVM. I could get output from the terminal when I use the command ' virsh qemu-monitor-event DOMAIN --timestamp --loop', but when using ' virsh qemu-monitor-event DOMAIN --timestamp --loop > /file ' to redirect the output to a file, I got nothing both from the terminal and the file.

virsh questions may be better asked on the libvirt-users mailing list,
as it is not part of qemu.git.

In your second invocation, you didn't use tee, so that would explain why
you got no output on the terminal. As for nothing in the file, are you
sure that you have a domain event occur during the time that virsh was
running?  But even when you end virsh, you should get a line stating
'events received: N' with the overall results.  The other thing that is
probably going on is that virsh is probably not doing anything special
about output buffering. When you output to a terminal, libc
automatically defaults to line-buffering (every time virsh writes \n,
the full line gets flushed right away); but when you output to a file,
libc's default behavior for stdout is to buffer things in FILE* buffers
until you hit a full buffer's worth, and only then flush (where exiting
virsh will force the flush of any final incomplete buffer), so using
'tail' on the file while virsh is still running in buffered mode will
only see output in bursts of multiple lines once the buffer finally
fills up and spills, rather than as they happen. You can use the
'stdbuf' utility from GNU Coreutils to force virsh into line-buffering
(via tricks with LD_PRELOAD) even when virsh is connected to a file
rather than a terminal.  Or submit a bug report to libvirt asking that
they explicitly set line-buffered output when doing qemu-monitor-event
rather than relying on libc's defaults (I don't know that forcing line
buffering makes sense for all virsh commands, but for ones that are
intended to be long-running and print events as they happen, it may be
worth doing).

Finally, note that the libvirt people declare qemu-monitor-event to be
non-supported (use-at-your-own-risk).  I use it myself when debugging
new features, but wouldn't trust it in production.  What are you really
trying to monitor with that command, and should libvirt itself be taught
to expose that particular event to you in a supported API instead of
forcing you to use the developer's unsupported backdoor monitoring?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
