Received: from eggs.gnu.org ([2001:4830:134:3::10]:41492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5wpv-0007SP-Rc
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5wps-00065P-Nr
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:09:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5wps-00064u-Hf
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:09:04 -0400
References: <20170227163447.20428-1-stefanha@redhat.com>
	<20170227163447.20428-2-stefanha@redhat.com>
	<20170503145418.GB27432@redhat.com>
	<182d640c-c892-993e-06d4-a9cdd9f363d6@redhat.com>
	<20170503153400.GD27432@redhat.com>
	<9489b184-019a-c644-a54f-b795f56f22a1@redhat.com>
	<20170503155544.GE27432@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6f1866f5-a36c-77f4-884b-093ee935ec1b@redhat.com>
Date: Wed, 3 May 2017 18:08:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170503155544.GE27432@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/4] curl: do not use
 aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 03/05/2017 17:55, Richard W.M. Jones wrote:
> On Wed, May 03, 2017 at 05:46:49PM +0200, Paolo Bonzini wrote:
>> Please test this:
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 2708d57c2f..cfe02bfd79 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -467,7 +467,9 @@ static CURLState *curl_init_state(BlockDriverState
>> *bs, BDRVCURLState *s)
>>              break;
>>          }
>>          if (!state) {
>> +            qemu_mutex_unlock(&s->mutex);
>>              aio_poll(bdrv_get_aio_context(bs), true);
>> +            qemu_mutex_lock(&s->mutex);
>>          }
>>      } while(!state);
>>
>>
> 
> Yes, this fixes it, thanks Paolo.
> 
> Reported-by: Kun Wei <kuwei@redhat.com>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>

Ok, will submit tomorrow formally.
