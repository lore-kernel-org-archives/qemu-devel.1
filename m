Received: from eggs.gnu.org ([2001:4830:134:3::10]:45918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOkX5-0000EW-9B
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOkWz-0005eo-QK
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:28:11 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-6-berrange@redhat.com>
	<5acd44f8-69c7-a791-0ce0-49cad6e48423@redhat.com>
	<20181119102732.GF19532@redhat.com>
	<5a677a31-ce10-cc2a-58b1-5589c20970da@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <30b19e80-a7c5-8012-e9ff-86ae2025ca15@redhat.com>
Date: Mon, 19 Nov 2018 08:27:56 -0600
MIME-Version: 1.0
In-Reply-To: <5a677a31-ce10-cc2a-58b1-5589c20970da@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: add iotests helpers for dealing
 with TLS certificates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 11/19/18 5:04 AM, Max Reitz wrote:

>>>> +tls_dir="${TEST_DIR}/tls"
>>>> +
>>>> +function tls_x509_cleanup()
>>>> +{
>>>> +    rm -f ${tls_dir}/*.pem
>>>> +    rm -f ${tls_dir}/*/*.pem
>>>> +    rmdir ${tls_dir}/*
>>>> +    rmdir ${tls_dir}
>>>
>>> Why not just:
>>> rm -rf $tls_dir
>>
>> Yeah, I guess we could do that for simplicity
>>
>>> Also, the quoting is a bit inconsistent. if ${TEST_DIR} can contain spaces,
>>> then all uses of ${tls_dir} need to be in "".
>>
>> Hmm, yes.
> 
> Which by the way is a very good reason *not* to blindly use "rm -r".

If we ever revive Jeff Cody's patches to let each test run with its own 
temporary directory, then we don't need this function at all.  With that 
in place, you either run the testsuite in debug mode (all temporary 
files preserved) or in normal mode (./check itself does rm -rf on the 
temporary directory).

> 
> So far we only seem to have one instance of "rm -r" in the iotests (and
> that is on three files, so I don't even know why that has -r), and I'm
> glad about that.

But until we have the global implementation of per-test temporary 
directories with cleanup relegated to the testsuite driver, I'm fine 
following your preference of explicit deletion of specific files rather 
than recursive deletion of the tree, even if it is more lines of code.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
