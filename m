Received: from eggs.gnu.org ([2001:4830:134:3::10]:37178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1eWpRS-0006Wo-Op
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1eWpRN-0007vM-Jn
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:15:14 -0500
Received: from sub5.mail.dreamhost.com ([208.113.200.129]:50166
	helo=homiemail-a81.g.dreamhost.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eager@eagerm.com>) id 1eWpRN-0007uJ-Bb
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:15:09 -0500
Received: from homiemail-a81.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a81.g.dreamhost.com (Postfix) with ESMTP id 0BBD66301
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:15:07 -0800 (PST)
Received: from [192.168.20.41] (c-73-170-242-219.hsd1.ca.comcast.net
	[73.170.242.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: eager@eagerm.com)
	by homiemail-a81.g.dreamhost.com (Postfix) with ESMTPSA id 205C65A25
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:15:05 -0800 (PST)
From: Michael Eager <eager@eagerm.com>
Message-ID: <b372ad89-0317-0206-c2aa-4a7acbbda685@eagerm.com>
Date: Wed, 3 Jan 2018 12:15:08 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Clock warping with -icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I'm trying to get -icount clock warping to work on an older QEMU source 
base.  In my test case, all vCPUs are idle and there is an outstanding 
timer.  What should happen (IMO) is that the qemu_icount value should be 
bumped to the timer value and then the timer callback should be called 
through qemu_notify_event().  This is not happening.  qemu_icount does 
not get updated and the code loops forever waiting for this to happen.

In my version of cpus.c in qemu_clock_warp(), the code calls 
icount_warp_rt(), which does not update qemu_icount, since 
vm_clock_warp_start is -1.  Subsequently, the pending timer is deleted,
vm_clock_warp_start is set to the current qemu_icount value, compared 
with the timer deadline, and then the timer is recreated with the same 
deadline.  (All of this looks like shuffling deck chairs on the Titanic. 
  The new timer is exactly the same as the old timer and there is no 
change in the clocks.)

I've compared this with the current QEMU sources in cpus.c.  Function 
names have changed and there are some other changes, but the code looks 
like it would do the same.  It isn't clear to me when/where qemu_icount 
or qemu_icount_bias would be modified to warp the clock ahead.

Can someone explain what vm_clock_warp_start is supposed to mean?  The
warp_delta value is computed by subtracting this from the current clock, 
which doesn't make sense to me.  IN qemu_start_warp_timer() it is set to 
the clock value.

Can someone offer me some clarifications on how warping the icount clock 
is done, or better yet send me (or tell me where to find) a working test 
case using QEMU and -icount which warps the icount timer when all vCPUs 
are idle?

Thanks in advance.

-- 
Michael Eager    eager@eagerm.com
1960 Park Blvd., Palo Alto, CA 94306
