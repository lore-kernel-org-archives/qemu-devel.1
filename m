Received: from eggs.gnu.org ([2001:4830:134:3::10]:39548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euL6I-0003fh-W4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euL6I-0001NK-2y
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:42:35 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euL6H-0001Mz-Up
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:42:34 -0500
Received: by mail-ot0-x241.google.com with SMTP id h8so9208896oti.6
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 08:42:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <096e970e-87f0-9aee-63a9-6d0194147b71@redhat.com>
References: <20180307130238.19358-1-pbonzini@redhat.com>
	<096e970e-87f0-9aee-63a9-6d0194147b71@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 16:42:12 +0000
Message-ID: <CAFEAcA8zOUcL0yiOPBU+t8zJ2PanJ8HbqLfi9QoB+7uCkwJZZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] memory: fix flatview_access_valid RCU read
 lock/unlock imbalance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, luigi burdo <intermediadc@hotmail.com>, Cornelia Huck <cohuck@redhat.com>

On 7 March 2018 at 13:29, Thomas Huth <thuth@redhat.com> wrote:
> On 07.03.2018 14:02, Paolo Bonzini wrote:
>> Fixes: 11e732a5ed46903f997985bed4c3767ca28a7eb6
>> Reported-by: Cornelia Huck <cohuck@redhat.com>
>> Reported-by: luigi burdo <intermediadc@hotmail.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  exec.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/exec.c b/exec.c
>> index 604f03c535..a9181e6417 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -3393,7 +3393,6 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
>>          if (!memory_access_is_direct(mr, is_write)) {
>>              l = memory_access_size(mr, l, addr);
>>              if (!memory_region_access_valid(mr, xlat, l, is_write)) {
>> -                rcu_read_unlock();
>>                  return false;
>>              }
>>          }
>>
>
> Thanks, this seems to fix the problem with the sam640ex and 40p machines.
>
> Tested-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to master since I ran into this too.

-- PMM
