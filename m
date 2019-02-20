Received: from eggs.gnu.org ([209.51.188.92]:45160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwVbs-0001iA-Os
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwVbr-00086Y-Kw
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:24:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwVbr-00084y-DE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:24:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so26959708wrw.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:24:39 -0800 (PST)
References: <20190220104523.22059-1-pbonzini@redhat.com>
	<87o9764dsb.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b3fe812b-62ac-4b28-416b-4780e11528c0@redhat.com>
Date: Wed, 20 Feb 2019 18:24:36 +0100
MIME-Version: 1.0
In-Reply-To: <87o9764dsb.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] shippable: fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 2/20/19 5:37 PM, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> It looks like something in netmap has changed and compilation fails:
>>
>>    install -D libnetmap.a //usr/local/lib/libnetmap.a
>>    install: cannot stat libnetmap.a: No such file or directory
>>
>> Add an explicit "make" step to fix it.
> 
> I took an alternate approach as tracking another projects master seems
> like a bad idea:
> 
> tests/docker: peg netmap code to a specific version
> 
> Tracking head is always going to be at the whims of the upstream.
> Let's use a defined release so things don't magically change under us.

Oh now I see your reply...

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> 1 file changed, 1 insertion(+)
> tests/docker/dockerfiles/debian-amd64.docker | 1 +
> 
> modified   tests/docker/dockerfiles/debian-amd64.docker
> @@ -33,6 +33,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
>          linux-headers-amd64
>  RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
> +RUN cd /usr/src/netmap && git checkout v11.3

... and I notice I forgot to change directory in my previous suggestion.

Why do you take v11.3 and not v11.4?
I agree v11.3 was closer to what I tested when I introduced this
dependency, but I'd rather use the latest release.

Regards,

Phil.

>  RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install
>  ENV QEMU_CONFIGURE_OPTS --enable-netmap
> 
> 
> <snip>
> 
> --
> Alex Bennée
> 
