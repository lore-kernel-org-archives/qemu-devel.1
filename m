Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eldb6-0003ZL-DV
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eldb1-00040t-Pf
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:38:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eldb1-0003zz-JL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:38:19 -0500
References: <20180128221510.13722-1-richard.henderson@linaro.org>
	<CAFEAcA_3s_prsUy7CXP3rC-i048FeEduqe92Mwg_VrTJ7YScHg@mail.gmail.com>
	<18af5519-95cd-f00e-1915-75183e94eb38@twiddle.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aff1a8c0-4e99-b52e-f933-fdc900bd91fd@redhat.com>
Date: Tue, 13 Feb 2018 10:38:18 -0600
MIME-Version: 1.0
In-Reply-To: <18af5519-95cd-f00e-1915-75183e94eb38@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Use *at functions to implement
 interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 02/13/2018 09:31 AM, Richard Henderson wrote:
>> I wonder if there are guest programs that make assumptions about
>> file descriptor numbers such that it would be worthwhile dup2'ing
>> the interp_dirfd away from the presumably low number fd it will
>> get by default into something larger...
> 
> Hmm.  Using dup2(probe, probe) to test if the new (high) fd itself has not been
> allocated?

fcntl(F_DUPFD[_CLOEXEC]) is smarter than dup2/3, if you plan on 
atomically guaranteeing a dup to a not-in-use fd.

Will dup'ing to a high fd violate assumptions of programs that assume 
that open() and friends favor the next available fd by default, rather 
than having a gap?  (Probably not, but skipping fds is not usual, so 
it's worth asking.)


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
