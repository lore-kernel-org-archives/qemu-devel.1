Received: from eggs.gnu.org ([2001:4830:134:3::10]:44403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chKIF-0006AT-5n
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chKIC-0005eB-52
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:08:35 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1chKIB-0005dh-Tq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:08:32 -0500
Received: by mail-wr0-x232.google.com with SMTP id 89so18108215wrr.3
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 10:08:31 -0800 (PST)
References: <CAJSP0QVjokCyvVtDcyWBhDqsWKwdNX6zyAo1uL9VmyzMfakS9A@mail.gmail.com>
	<87y3wwy9gb.fsf@linaro.org>
	<a1cfbe26-c85a-e521-dfcf-5b31913394c4@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a1cfbe26-c85a-e521-dfcf-5b31913394c4@redhat.com>
Date: Fri, 24 Feb 2017 18:08:29 +0000
Message-ID: <87h93jlaw2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Hang in aio/multi/mutex/mcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/02/2017 20:48, Alex Bennée wrote:
>> Hope that helps the debugging ;-)
>
> Worst case we can just remove the test (it's only there for performance
> comparison, not a bug in actual QEMU code), but this seems to help here:
>
> diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
> index f11e990..8b0b40e 100644
> --- a/tests/test-aio-multithread.c
> +++ b/tests/test-aio-multithread.c
> @@ -309,7 +309,7 @@ static void mcs_mutex_lock(void)
>  static void mcs_mutex_unlock(void)
>  {
>      int next;
> -    if (nodes[id].next == -1) {
> +    if (atomic_read(&nodes[id].next) == -1) {
>          if (atomic_read(&mutex_head) == id &&
>              atomic_cmpxchg(&mutex_head, id, -1) == id) {
>              /* Last item in the list, exit.  */
> @@ -323,7 +323,7 @@ static void mcs_mutex_unlock(void)
>      }
>
>      /* Wake up the next in line.  */
> -    next = nodes[id].next;
> +    next = atomic_read(&nodes[id].next);
>      nodes[next].locked = 0;
>      qemu_futex_wake(&nodes[next].locked, 1);
>  }

Well it certainly looks like it improves the results on Travis.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
