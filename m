Received: from eggs.gnu.org ([2001:4830:134:3::10]:35776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSl3a-00050I-Tg
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSl3W-0004vh-Oj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:50:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSl3W-0004vK-GM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:50:14 -0500
Date: Fri, 30 Nov 2018 15:50:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130155003.GG9162@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1543513531-1151-3-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543513531-1151-3-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eblake@redhat.com

On Thu, Nov 29, 2018 at 06:45:31PM +0100, Paolo Bonzini wrote:
> gtester is deprecated by upstream glib and it does not support tests
> that call g_test_skip in some glib stable releases.
> 
> glib suggests instead using Automake's TAP support.  We do not support
> Automake, but we can copy the code that beautifies the TAP output and
> use it.  I chose to use the Perl copy rather than the shell/awk one,
> in order to reuse Perl's TAP parsing package, but I'm open to suggestions
> about which language to use.

Do we even need the beutifier ?

IIUC, this output is only seen when you with 'make check' passing V=1,
so most people won't see it.

When V=1 is set, it just changes:

$ ./tests/test-io-channel-socket -k --tap
# random seed: R02Sb9d02d2a9658ae1be211540f5ceebc01
1..9
# Start of io tests
# Start of channel tests
# Start of socket tests
ok 1 /io/channel/socket/ipv4-sync
ok 2 /io/channel/socket/ipv4-async
ok 3 /io/channel/socket/ipv4-fd
ok 4 /io/channel/socket/ipv6-sync
ok 5 /io/channel/socket/ipv6-async
ok 6 /io/channel/socket/unix-sync
ok 7 /io/channel/socket/unix-async
**
ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)
Bail out! ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)
Aborted (core dumped)


To look like:

$ ./tests/test-io-channel-socket -k --tap | ./scripts/tap-driver.pl 
PASS 1 /io/channel/socket/ipv4-sync
PASS 2 /io/channel/socket/ipv4-async
PASS 3 /io/channel/socket/ipv4-fd
PASS 4 /io/channel/socket/ipv6-sync
PASS 5 /io/channel/socket/ipv6-async
PASS 6 /io/channel/socket/unix-sync
PASS 7 /io/channel/socket/unix-async
ERROR - Bail out! ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)

where 'PASS' is coloured in green and 'ERROR' is red. I'm not
convinced this change justifies having the tap-driver.pl script

Since this commit already proposes a dep on the perl-Test-Harness
package, the host will have the 'prove' command, which can be used
for invoking tests.

Prove just needs a wrapper to know how to invoke glib tests:

  $ cat glibharness.sh 
  #!/bin/sh

  exec "$@" -k --tap

Now you can run :

$ prove -v -e ./glibharness.sh  tests/test-io-channel-socket
tests/test-io-channel-socket .. 
# random seed: R02S7b47ca0de1bc27cbbcf22dcc130c2b7f
1..9
# Start of io tests
# Start of channel tests
# Start of socket tests
ok 1 /io/channel/socket/ipv4-sync
ok 2 /io/channel/socket/ipv4-async
ok 3 /io/channel/socket/ipv4-fd
ok 4 /io/channel/socket/ipv6-sync
ok 5 /io/channel/socket/ipv6-async
ok 6 /io/channel/socket/unix-sync
ok 7 /io/channel/socket/unix-async
**
ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)
Bailout called.  Further testing stopped:  ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)
Bail out! ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)
FAILED--Further testing stopped: ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)


Where the failure line is now coloured in Red (or sucess is coloured
in green)

prove can also run tests in batches, giving progress of execution of
each test as it runs

$ prove  -e ./glibharness.sh  tests/test-io-channel-{buffer,command,file,socket,tls} 
tests/test-io-channel-buffer ... ok   
tests/test-io-channel-command .. ok   
tests/test-io-channel-file ..... ok   
tests/test-io-channel-socket ... 1/? **
ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)
Bailout called.  Further testing stopped:  ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)
FAILED--Further testing stopped: ERROR:tests/test-io-channel-socket.c:424:test_io_channel_unix_fd_pass: assertion failed: (0)


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
