Received: from eggs.gnu.org ([2001:4830:134:3::10]:51578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUa0J-0006eC-TA
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUa0I-0008Mu-W5
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:26:27 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-5-eblake@redhat.com>
	<25e2852c-7bf8-dadd-8c0d-32c2229ed187@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <211449a7-01ef-abcb-88c0-15d2eda67d6e@redhat.com>
Date: Wed, 5 Dec 2018 10:26:05 -0600
MIME-Version: 1.0
In-Reply-To: <25e2852c-7bf8-dadd-8c0d-32c2229ed187@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/14] qemu-nbd: Simplify --partition
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/5/18 9:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.12.2018 1:03, Eric Blake wrote:
>> Our open-coding of strtol handling forgot to handle overflow
>> conditions. What's more, since we insiste on a user-supplied
>> partition to be non-zero, we can use 0 rather than -1 for our
>> initial value to distinguish when a partition is not being
>> served, for slightly more optimal code.
>>

>> -            if (partition < 1 || partition > 8) {
>> -                error_report("Invalid partition %d", partition);
>> +            if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||
> 
> I decided to look into qemu_strtoi, hmm.
> 
> is it possible, that "char *ep" remains uninitialized, and than we access
> it in check_strtox_error? I don's see in strtol spec a guarantee of setting
> endptr on failure path.

C99 7.10.1.4 P5-7 requires strtoll() and friends to assign through 
'endptr' if it is non-NULL, for both success and ERANGE failure cases. 
POSIX then further requires 'endptr' to be set for EINVAL failures due 
to out-of-range 'base' (not that we have any such callers), and permits 
(but does not require) the empty string to cause an EINVAL failure (but 
whether or not EINVAL happened, 'endptr' is still set).  There are no 
other possible failures, so no, we are not dereferencing an 
uninitialized variable in check_strtox_error.

> 
> 
>> +                partition < 1 || partition > 8) {
> 
> don't you like brace on separate line after multi-line conditions?

CODING_STYLE is silent on the matter; checkpatch.pl allows either style 
for multi-line, while requesting the same line as the condition for 
one-line (see commit a97ceca57).  But since I'm already in the habit of 
putting { right after the condition because of checkpatch, I don't go 
out of my way to put it on its own line after multi-line conditionals. 
I don't think it matters too much.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
