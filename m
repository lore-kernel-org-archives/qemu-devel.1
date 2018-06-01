Received: from eggs.gnu.org ([2001:4830:134:3::10]:37269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOjDE-0007fK-Df
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOjDB-0007FO-Av
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:31:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOjDB-0007F2-58
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:31:17 -0400
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-4-slp@redhat.com>
	<CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
	<20180601115212.GU3458@redhat.com>
	<20180601120538.guwfrzojgabnpofb@dritchie>
	<c543d390-c034-ce60-5699-aa78186eb51d@redhat.com>
	<20180601122815.lh46wcg6rfpcooyk@dritchie>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bc91e8f-0d97-45ab-fcb6-c2b6175346e1@redhat.com>
Date: Fri, 1 Jun 2018 14:31:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180601122815.lh46wcg6rfpcooyk@dritchie>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on
 serial_xmit if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 01/06/2018 14:28, Sergio Lopez wrote:
> On Fri, Jun 01, 2018 at 02:16:59PM +0200, Paolo Bonzini wrote:
>> On 01/06/2018 14:05, Sergio Lopez wrote:
>>>>> Instead of adding explicit handling of EPIPE, shouldn't the code be
>>>>> rewritten to treat -1 return && errno != EAGAIN as fatal?
>>>> Yes, exactly this code is already broken for every single errno
>>>> value, not simply EPIPE. It needs fixing to treat '-1' return code
>>>> correctly instead of retrying everything.
>>> Given that EAGAIN is already taken care of in
>>> chardev/char.c:qemu_chr_write_buffer, in which cases should we retry? Or
>>> should we just drop all the tsr_retry logic?
>>
>> It's not handled there, the call from qemu_chr_fe_write has write_all ==
>> false.
> 
> You're right. So should we just retry only for -1 && errno == EAGAIN and
> just ignore the error otherwise?

Probably, yes.

Paolo
