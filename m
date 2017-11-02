Received: from eggs.gnu.org ([2001:4830:134:3::10]:43892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADkg-0007LP-Hx
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADkb-0008Aq-2O
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:33:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eADka-000885-Sa
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:33:33 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
	<a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
	<001501d353cd$29099010$7b1cb030$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18ddcf7c-0198-a0ce-c2cc-992131512897@redhat.com>
Date: Thu, 2 Nov 2017 12:33:22 +0100
MIME-Version: 1.0
In-Reply-To: <001501d353cd$29099010$7b1cb030$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 19/26] cpu-exec: reset exit flag before
 calling cpu_exec_nocache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 02/11/2017 12:24, Pavel Dovgalyuk wrote:
>> I am not sure about this.  I think if instead you should return false
>> from here and EXCP_INTERRUPT from cpu_exec.
> The problem is inside the TB. It checks cpu->icount_decr.u16.high which is -1.
> And we have to enter the TB to cause an exception (because it exists in replay log).
> That is why we reset this flag and try to execute the TB.

But if u16.high is -1, shouldn't you return EXCP_INTERRUPT first (via
"Finally, check if we need to exit to the main loop" in
cpu_handle_interrupt)?  Then only cause the exception when that one is
processed.

Paolo

>> More important: there is still a race, because high can be set to -1
>> right after your atomic_set.
> I'm not sure about it. But even the race exists, exec_nocache attempt will be repeated
> after failed try.
> 
> Returning true is ok here, because we know that exception will happen (because it is
> recorded in the log).
