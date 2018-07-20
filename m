Received: from eggs.gnu.org ([2001:4830:134:3::10]:55576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgbsY-0000GN-Ub
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 16:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgbsX-00012g-F2
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 16:19:54 -0400
References: <20180706164542.9476-1-kwolf@redhat.com>
	<be1b9d41-1eb3-c24c-c459-cc6d6599de22@redhat.com>
	<20180709093214.GA3511@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee9f7567-71d2-385d-137a-4c462b1adb07@redhat.com>
Date: Fri, 20 Jul 2018 15:19:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180709093214.GA3511@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Fix copy-on-read crash with partial
 final cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On 07/09/2018 04:32 AM, Kevin Wolf wrote:
> Am 06.07.2018 um 23:20 hat Eric Blake geschrieben:
>> On 07/06/2018 11:45 AM, Kevin Wolf wrote:
>>> If the virtual disk size isn't aligned to full clusters,
>>> bdrv_co_do_copy_on_readv() may get pnum == 0 before having the full
>>> cluster completed, which will let it run into an assertion failure:
>>>
>>> qemu-io: block/io.c:1203: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
>>>
>>> Check for EOF, assert that we read at least as much as the read request
>>> originally wanted to have (which is true at EOF because otherwise
>>> bdrv_check_byte_request() would already have returned an error) and
>>> return success early even though we couldn't copy the full cluster.
>>>

>>> +echo
>>> +echo '=== Partial final cluster ==='
>>> +echo
>>> +
>>> +_make_test_img 1024
>>> +$QEMU_IO -f $IMGFMT -C -c 'read 0 1024' "$TEST_IMG" | _filter_qemu_io
>>
>> Here, $TEST_IMG has no backing file, and does not have the final
>> cluster allocated; all we have to do is properly read all zeroes.
> 
> And write them back, we test that it's allocated afterwards.
> 
>> Is it worth also explicitly testing reading of allocated data under
>> COR
> 
> I could add a second read of the same area, which would not only test
> reading of allocated data, but also test whether the allocating COR
> wrote the correct data (all zeros).
> 
> Do you think that would be a worthwhile addition?

It can't hurt (we've already proven that our iotests coverage is 
incomplete, and anything we can do to enhance it improves chances of it 
catching unintentional regressions).

> 
>> and/or the case of one image with another backing image (with
>> same or differing partial cluster sizes), where COR actually has to
>> write the partial cluster?  However, the logic in the code appears to
>> cover all of those, whether or not the testsuite does as well.
> 
> Having a backing file is a different code path for non-zero data, but I
> think we already test normal write/write_zeroes extensively. For zero
> data, it doesn't make a difference whether it comes from the backing
> file or from not having a backing file (as far as the COR logic is
> concerned, anyway).
> 
> I didn't want to use a backing file because the test is 'generic', but
> it already uses qcow2 in other cases, so if we really think this is
> important to have, I guess I can have another case with qcow2 over
> $IMGFMT and non-zero data.

At this point, I'm not volunteering to write such test enhancements, and 
I don't think it's a show-stopper if 3.0 uses the test as currently in git.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
