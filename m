Received: from eggs.gnu.org ([2001:4830:134:3::10]:59871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrY6-0002xL-NI
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrY5-0003F9-Pr
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:13:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-10-f4bug@amsat.org>
	<20180529134053.1ea9f46d.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11289f38-6d0f-74c9-1719-83b2a3ed2d97@amsat.org>
Date: Wed, 30 May 2018 00:12:55 -0300
MIME-Version: 1.0
In-Reply-To: <20180529134053.1ea9f46d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 09/21] target: Do not include
 "exec/exec-all.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

Hi Cornelia,

On 05/29/2018 08:40 AM, Cornelia Huck wrote:
> On Mon, 28 May 2018 20:27:07 -0300
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> Code change produced with:
>>     $ git grep '#include "exec/exec-all.h"' | \
>>       cut -d: -f-1 | \
>>       xargs egrep -L "(cpu_address_space_init|cpu_loop_|tlb_|tb_|GETPC|singlestep|TranslationBlock)" | \
> 
> Hm, does this expression catch all files that need to include
> exec-all.h? The resulting patch seems fine, though.

No, not all :/
I started with "(cpu_loop_|tlb_|tb_)" then kept brutebuilding until no
more errors appear. In 2 more steps I added "cpu_address_space_init|"
then "|GETPC|singlestep|TranslationBlock". Quick and dirty enough for my
goal than trying to build a regex to explode function/struct names from
headers. This is a clever way to do it for long term command reuse taken
from commit messages...

>>       xargs sed -i.bak '/#include "exec\/exec-all.h"/d'
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
