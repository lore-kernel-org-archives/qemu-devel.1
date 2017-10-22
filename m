Received: from eggs.gnu.org ([2001:4830:134:3::10]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1e6Hog-0002IR-H2
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 11:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1e6Hod-0004Vy-Ci
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 11:05:30 -0400
Received: from bitwagon.com ([2001:470:0:e6::4a52:27af]:50083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jreiser@bitwagon.com>)
	id 1e6Hod-0004VU-4u
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 11:05:27 -0400
Received: from f25e64.local ([71.36.99.203]) by bitwagon.com
	for <qemu-devel@nongnu.org>; Sun, 22 Oct 2017 08:05:21 -0700
References: <20171020175548.2566-1-programmingkidx@gmail.com>
	<f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
	<20171022053315.GA15297@umbus>
	<82BA0070-FFBB-4868-AE48-D7A3671621C5@gmail.com>
From: John Reiser <jreiser@bitwagon.com>
Message-ID: <c461944a-a663-5bf8-1152-87a483f5c7a0@bitwagon.com>
Date: Sun, 22 Oct 2017 08:05:21 -0700
MIME-Version: 1.0
In-Reply-To: <82BA0070-FFBB-4868-AE48-D7A3671621C5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libfdt][PATCH v2] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> ...  this one is even smaller. Plus it uses the familiar strlen() function:
> 
> size_t strnlen(const char *string, size_t max_count)
> {
>      return strlen(string) < max_count ? strlen(string) : max_count;
> }
> 

Please do not use that implementation.
The major goal of strnlen is to avoid looking beyond &string[max_count].
strlen(string) looks all the way to the end, which may be very much longer than max_count;
and which may cause SIGSEGV by running into a memory page that does not exist
before the terminating '\0' is found.
[Besides, some compilers do not recognize that "strlen(string)"
need not be evaluated twice.]

-- 
