Received: from eggs.gnu.org ([2001:4830:134:3::10]:55410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dxa6P-00087t-Bv
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dxa6K-0002p9-OB
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:47:49 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:45635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dxa6K-0002oE-Fw
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:47:44 -0400
Received: by mail-wr0-x22c.google.com with SMTP id m18so3143122wrm.2
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 07:47:42 -0700 (PDT)
References: <20170925075458.18047-1-famz@redhat.com>
	<CAAdtpL5j_9qh2bmzpmx3ULgCFr8TkMF4AgUZF=7Ka66=3diD3A@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAAdtpL5j_9qh2bmzpmx3ULgCFr8TkMF4AgUZF=7Ka66=3diD3A@mail.gmail.com>
Date: Thu, 28 Sep 2017 15:47:39 +0100
Message-ID: <87lgkydgms.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker: Don't mount ccache db if NOUSER=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> On Mon, Sep 25, 2017 at 4:54 AM, Fam Zheng <famz@redhat.com> wrote:
>> With NOUSER=1 the container runs code as root, which may create
>> privileged files that will not be be accssible next time. Skip ccache
>> dir mount in this case.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>
> Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Makes sense:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

>
>> ---
>>  tests/docker/Makefile.include | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index 0e4f159619..6f9ea196a7 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -143,9 +143,11 @@ docker-run: docker-qemu-src
>>                         -e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
>>                         -e V=$V -e J=$J -e DEBUG=$(DEBUG)               \
>>                         -e SHOW_ENV=$(SHOW_ENV)                         \
>> -                       -e CCACHE_DIR=/var/tmp/ccache                   \
>> +                       $(if $(NOUSER),,                                \
>> +                               -e CCACHE_DIR=/var/tmp/ccache           \
>> +                               -v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z \
>> +                       )                                               \
>>                         -v $$(readlink -e $(DOCKER_SRC_COPY)):/var/tmp/qemu:z$(COMMA)ro \
>> -                       -v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z       \
>>                         $(IMAGE)                                        \
>>                         /var/tmp/qemu/run                               \
>>                         $(TEST), "  RUN $(TEST) in ${IMAGE}")
>> --
>> 2.13.5
>>


--
Alex Bennée
