Received: from eggs.gnu.org ([2001:4830:134:3::10]:50426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcd7-00033X-4X
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcd3-0001vb-W5
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:31:37 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcd3-0001vI-SW
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:31:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id f18-v6so24226703qtp.10
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:31:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-13-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ddd1e924-a3a3-8ce1-283e-2d3cc616d207@amsat.org>
Date: Thu, 12 Jul 2018 11:31:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180712111221.20326-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/20] cpu-plug-test: Don't pass integers
 as strings to device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 07/12/2018 08:12 AM, Markus Armbruster wrote:
> test_plug_with_device_add_x86() plugs Haswell-i386-cpu and
> Haswell-x86_64-cpu with device_add.  It passes socket-id, core-id,
> thread-id as JSON strings.  The properties are actually integers.
> 
> test_plug_with_device_add_coreid() plugs power8_v2.0-spapr-cpu-core
> and qemu-s390x-cpu with device_add.  It passes core-id as JSON string.
> The properties are actually integers.
> 
> Passing JSON string values to integer properties works only due to
> device_add implementation accidents.  Fix the test to pass JSON
> numbers.  While there, use %u rather than %i with unsigned int.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/cpu-plug-test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
> index 5f39ba0df3..ab3bf6df90 100644
> --- a/tests/cpu-plug-test.c
> +++ b/tests/cpu-plug-test.c
> @@ -88,8 +88,8 @@ static void test_plug_with_device_add_x86(gconstpointer data)
>          for (c = 0; c < td->cores; c++) {
>              for (t = 0; t < td->threads; t++) {
>                  char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
> -                qtest_qmp_device_add(td->device_model, id, "'socket-id':'%i', "
> -                                     "'core-id':'%i', 'thread-id':'%i'",
> +                qtest_qmp_device_add(td->device_model, id, "'socket-id':%u, "
> +                                     "'core-id':%u, 'thread-id':%u",
>                                       s, c, t);
>                  g_free(id);
>              }
> @@ -114,7 +114,7 @@ static void test_plug_with_device_add_coreid(gconstpointer data)
>  
>      for (c = td->cores; c < td->maxcpus / td->sockets / td->threads; c++) {
>          char *id = g_strdup_printf("id-%i", c);
> -        qtest_qmp_device_add(td->device_model, id, "'core-id':'%i'", c);
> +        qtest_qmp_device_add(td->device_model, id, "'core-id':%u", c);
>          g_free(id);
>      }
>  
> 
