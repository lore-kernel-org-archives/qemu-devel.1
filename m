Received: from eggs.gnu.org ([2001:4830:134:3::10]:34250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZitO-0005Kw-EN
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZitL-0006VO-Ag
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:19:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-24-f4bug@amsat.org>
	<4de3bb09-6894-ee92-eb49-0f64efe1bad8@vivier.eu>
	<0a7a2681-4702-5334-aaa8-e477aaa5c98a@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6c893f10-2772-8a2e-b247-388222589c83@amsat.org>
Date: Mon, 24 Jul 2017 16:19:38 -0300
MIME-Version: 1.0
In-Reply-To: <0a7a2681-4702-5334-aaa8-e477aaa5c98a@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 23/35] m68k/translate: fix
 incorrect copy/paste
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 07/24/2017 04:01 PM, Richard Henderson wrote:
> On 07/24/2017 11:54 AM, Laurent Vivier wrote:
>> Le 24/07/2017 à 20:27, Philippe Mathieu-Daudé a écrit :
>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>> index ada2a91b64..1a2f421aab 100644
>>> --- a/target/m68k/translate.c
>>> +++ b/target/m68k/translate.c
>>> @@ -1321,7 +1321,8 @@ static void gen_cc_cond(DisasCompare *c, 
>>> DisasContext *s, int cond)
>>>       case 5: /* CS (C) */
>>>           /* Some cases fold C into X.  */
>>>           if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == 
>>> CC_OP_ADDL ||
>>> -            op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
>>> +            op == CC_OP_SUBB || op == CC_OP_SUBW || op == CC_OP_SUBL ||
>>> +            op == CC_OP_LOGIC) {
>>
>> According to commit (db3d7945) introducing the incorrect copy/paste, I
>> don't think we need the CC_OP_LOGIC here. Logic operations never
>> generates X flags (whereas they can generate Z and and N).
> 
> Indeed, look at the comment below.  LOGIC is supposed to fall through to 
> the code that produces TCG_COND_NEVER.

Indeed I also miss-copypasted :)

So the correct fix would be:?

          if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
-            op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
+            op == CC_OP_SUBB || op == CC_OP_SUBW || op == CC_OP_SUBL) {
