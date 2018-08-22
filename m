Received: from eggs.gnu.org ([2001:4830:134:3::10]:55584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsbBn-0005Ld-De
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsbBm-0006t3-IF
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:01:19 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
	<7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7607375c-4840-aab5-d7ff-cdf9fa1e79cf@redhat.com>
Date: Wed, 22 Aug 2018 17:01:02 -0500
MIME-Version: 1.0
In-Reply-To: <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com

On 08/22/2018 06:43 AM, Max Reitz wrote:
> On 2018-08-17 21:04, John Snow wrote:
>> All jobs do the same thing when they leave their running loop:
>> - Store the return code in a structure
>> - wait to receive this structure in the main thread
>> - signal job completion via job_completed
>>
>> Few jobs do anything beyond exactly this. Consolidate this exit
>> logic for a net reduction in SLOC.
>>

> OK, so that's that.  Now that I know what it's for, I'd like to ask for
> a different name.  exit() means kill the process.  JobDriver.exit() will
> not mean kill the job.  That's where I get a headache.
> 
> This function is for allowing the job to carry out global qemu state
> modifications in the main loop.  Neither is that exiting in the sense
> that the job is destroyed (as this is done only later, and the job gets
> to take part in it through the transactional callbacks, and .free()),
> nor is it exiting in the sense that the job needs to do all
> pre-transactional clean-ups here (they are supposed to do that in .run()
> -- *unlees* something needs the main loop).
> 
> I'd like .main_loop_settle().  Or .main_loop_post_run().  I think it's
> OK to have names that aren't as cool and tense as possible, when in
> return they actually tell you what they're doing.  (Sure,
> .main_loop_post_run() sounds really stupid, but it tells you exactly
> when the function is called and what it's for.)
> 
> (Maybe the problem of all your naming woes really is just that you
> always try to find a single word that describes what's going on :-) -- I
> don't want to go into ProblemSolveFactoryObserverFactorySingleton
> either, but it's OK to use an underscore once in a while.)

Does .wrapup or .conclude work any better than .exit for such a one-word 
name that goes away in the next series?  Actually, your suggestion of 
.settle seems reasonable to me (if we want terser than 
.main_loop_settle, because the name is going away, but still have a name 
that is not as weird as '.exit' when there are more steps still to follow)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
