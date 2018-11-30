Received: from eggs.gnu.org ([2001:4830:134:3::10]:41727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSmvx-0000RQ-8t
	for Qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSmvt-0006cS-7i
	for Qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:50:33 -0500
References: <cover.1543593569.git.alifm@linux.ibm.com>
	<cb554c04ee50ac970fa10edaa090982bef18f673.1543593569.git.alifm@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eaba14ba-5c92-34d4-ab7c-3cc5aefdcccb@redhat.com>
Date: Fri, 30 Nov 2018 11:50:27 -0600
MIME-Version: 1.0
In-Reply-To: <cb554c04ee50ac970fa10edaa090982bef18f673.1543593569.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for 3.1? or 4 v2 1/1] qemu-iotests: Don't run
 the test when user is root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Adding qemu-devel - all patches should go there, especially if you want 
to get Peter's attention that this might be a 3.1 candidate if we have 
other reasons to spin -rc4.

On 11/30/18 10:04 AM, Farhan Ali wrote:
> Test 232 creates image files with read-only permission and
> expects an error message when trying to access the image
> files with read-only and auto-read-only turned off.
> 
> Don't run as root user, since root can open files with read/write
> access for read-only files.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   tests/qemu-iotests/232 | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
> index 0708b8b..05d5f2f 100755
> --- a/tests/qemu-iotests/232
> +++ b/tests/qemu-iotests/232
> @@ -41,6 +41,14 @@ _supported_fmt generic
>   _supported_proto file
>   _supported_os Linux
>   
> +tmp='file'
> +touch $tmp
> +chmod a-w $tmp
> +if [ -w $tmp ]
> +then
> +    _notrun "Cannot run this test as root user"
> +fi
> +

I know you just copied from my suggestion, but now looking at it, this 
leaves 'tmp' around in the directory for both success and skip. Better 
might be to just check whether $TEST_IMG is writable, immediately after 
the existing 'chmod a-w $TEST_IMG' line (Hmm - that line is already 
broken for not quoting "$TEST_IMG" in case it contains whitespace).

I don't see this being a reason for -rc4 on its own (most people don't 
run iotests as root); and the fact that we're still working on the final 
contents of what the patch should contain, as well as the fact that the 
patch doesn't affect the main binaries, means that if it were up to me, 
I'd defer it to 4.0. Kevin may have a different opinion, though, since 
it is his test, and new to 3.1.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
