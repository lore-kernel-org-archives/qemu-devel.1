Received: from eggs.gnu.org ([2001:4830:134:3::10]:48670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEh-000489-37
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEd-0006uT-WB
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:19 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:36422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPDEd-0006td-S1
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:30:15 -0400
Received: by mail-qk0-x235.google.com with SMTP id p21so65333476qke.3
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 12:30:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 25 Jun 2017 16:29:49 -0300
Message-Id: <20170625192950.17677-4-f4bug@amsat.org>
In-Reply-To: <20170625192950.17677-1-f4bug@amsat.org>
References: <20170625192950.17677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/4] coccinelle: script to run them all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/check-cocci-scripts.sh | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 scripts/check-cocci-scripts.sh

diff --git a/scripts/check-cocci-scripts.sh b/scripts/check-cocci-scripts.sh
new file mode 100755
index 0000000000..ec3a8b39ef
--- /dev/null
+++ b/scripts/check-cocci-scripts.sh
@@ -0,0 +1,47 @@
+#! /usr/bin/env bash
+
+test -d scripts/coccinelle || exit 1
+
+SPATCH_IMAGE="philmd/coccinelle:1.0.4"
+
+GIT_AUTHOR_NAME="Coccinelle Spatch"
+GIT_COMMITTER_NAME="Coccinelle Spatch"
+
+if [ -n "$TRAVIS" ]; then
+	# avoid stalling builds: https://docs.travis-ci.com/user/common-build-problems/#Build-times-out-because-no-output-was-received
+	TIMEOUT_S=530
+	TIMEOUT_CMD="timeout -k 550 500"
+	EXTRA_ARGS="--timeout ${TIMEOUT_S}"
+else
+	TIMEOUT_S=0
+fi
+
+HEAD=19 #`echo -n scripts/coccinelle/ | wc -c`
+TAIL=6 #`echo -n .cocci | wc -c`
+
+test -z "$(${SUDO} docker images -q ${SPATCH_IMAGE})" && ${SUDO} docker pull ${SPATCH_IMAGE}
+
+LOG=/tmp/cocci-spatch-$$
+for script in scripts/coccinelle/*.cocci; do
+	desc=${script:$HEAD:-$TAIL}
+	echo -e "\nRunning ${script}...\n"
+	echo -e "coccinelle: committing changes after running \"$desc\" script\n" > ${LOG}.topic
+	${TIMEOUT_CMD} ${SUDO} \
+	docker run --rm -v `pwd`:`pwd` -w `pwd` -u `id -u` \
+		${SPATCH_IMAGE} --use-cache --use-gitgrep --keep-comments \
+			--very-quiet ${EXTRA_ARGS} \
+			--sp-file ${script} \
+			--macro-file scripts/cocci-macro-file.h \
+			--dir . \
+			--in-place | tee ${LOG}.content
+	git add -u
+	git diff --cached --exit-code -s
+	if [ $? -ne 0 ]; then
+		:> ${LOG}.content
+	else
+		test -s ${LOG}.content || continue
+	fi
+	cat ${LOG}.{topic,content} | git commit --allow-empty -F -
+done
+
+rm -f ${LOG}.{topic,content}
-- 
2.13.1
