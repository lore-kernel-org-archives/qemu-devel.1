Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAGia-00062e-B4
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAGiX-0005yh-6K
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eAGiX-0005xY-0h
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:43:37 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
	<a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
	<001501d353cd$29099010$7b1cb030$@ru>
	<18ddcf7c-0198-a0ce-c2cc-992131512897@redhat.com>
	<001801d353d8$77016da0$650448e0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f57db92-25e0-362a-6130-dfa116fd43a2@redhat.com>
Date: Thu, 2 Nov 2017 15:43:26 +0100
MIME-Version: 1.0
In-Reply-To: <001801d353d8$77016da0$650448e0$@ru>
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

On 02/11/2017 13:45, Pavel Dovgalyuk wrote:
>> But if u16.high is -1, shouldn't you return EXCP_INTERRUPT first (via
>> "Finally, check if we need to exit to the main loop" in
>> cpu_handle_interrupt)?  Then only cause the exception when that one is
>> processed.
> The case is the following.
> 1. There are no pending instructions to execute, cpu_loop_exec_tb finished.
> 2. There are no interrupts and cpu_handle_interrupt sets cpu->exception_index = EXCP_INTERRUPT
> 3. There are no pending exceptions and cpu_handle_exception goes to the last branch,
>    because there is an exception flag in the log.
> 4. cpu_exec_nocache translates the block and tries to execute it, causing an exception
> 

Then the fix is indeed to clear u16.high in cpu_handle_interrupt instead
of cpu_loop_exec_tb---see my other reply.

Paolo
