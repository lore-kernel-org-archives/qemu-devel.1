Received: from eggs.gnu.org ([209.51.188.92]:47245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzQIE-0002Rl-Vt
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzQID-0003oO-6B
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:20:26 -0500
References: <20190227162035.18543-1-berrange@redhat.com>
	<20190227162035.18543-2-berrange@redhat.com>
	<29dfdc31-9e4d-88be-13f0-53e3f33d6800@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75393117-5893-4ca1-f86b-83913a924e53@redhat.com>
Date: Thu, 28 Feb 2019 12:20:16 -0600
MIME-Version: 1.0
In-Reply-To: <29dfdc31-9e4d-88be-13f0-53e3f33d6800@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/3] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

On 2/27/19 10:43 AM, Eric Blake wrote:

>>  @example
>>  qemu-nbd \
>>    --object tls-creds-x509,id=tls0,endpoint=server,dir=/path/to/qemutls \
>> -  --tls-creds tls0 -t -x subset -p 10810 \
>> +  --object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,\
>> +            O=Example Org,,L=London,,ST=London,,C=GB' \
> 
> A long line may be necessary here, unless the whitespace in the
> identity= parameter inserted by the line continuation is harmless.  Long
> lines in man pages are annoying, but even worse is an example that
> copies-and-pastes incorrectly.  I may just s/^ *O/O/.

I've just confirmed that whitespace in the identity= parameter is
harmless, via this change:

diff --git i/tests/qemu-iotests/233 w/tests/qemu-iotests/233
index 6adade45353..5e5fe1e8cdb 100755
--- i/tests/qemu-iotests/233
+++ w/tests/qemu-iotests/233
@@ -131,7 +131,8 @@ nbd_server_stop

 nbd_server_start_tcp_socket \
     --object
tls-creds-x509,dir=${tls_dir}/server1,endpoint=server,id=tls0,verify-peer=yes
\
-    --object "authz-simple,identity=CN=localhost,,O=Cthulu Dark Lord
Enterprises client1,,L=R'lyeh,,C=South Pacific,id=authz0" \
+    --object "authz-simple,id=authz0,identity=CN=localhost,, \
+      O=Cthulu Dark Lord Enterprises client1,,L=R'lyeh,,C=South Pacific" \
     --tls-authz authz0 \
     --tls-creds tls0 \
     -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"


So I'll go ahead and tweak the patch along those lines.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
